// requirejs.config({
//     //By default load any module IDs from js/lib
//     baseUrl: '/static/js',
//     //except, if the module ID starts with "app",
//     //load it from the js/app directory. paths
//     //config is relative to the baseUrl, and
//     //never includes a ".js" extension since
//     //the paths config could be for a directory.
//     paths: {
//         jquery: 'libs/jquery'
//         // util: '', 
//         // uri: '../uri.js', 
//     }    
// });

require(['jquery', 'util'], function($, util) {
    
    var geoJSONEndpoint = '/static/geojson/all.geojson';

    // holds all features loaded from backend 
    var allFeatures = [];

    // active facet selections 
    var facetSelection = {};

    // An index holds:
    // 
    //    { 'offering-id' -> [
    //        'feature': feature, 
    //        'marker' : marker/layer 
    //      ]
    //    }
    // 

    // indexed markers 
    // pIndex is for properties
    var pIndex = {};
    // sIndex is for services 
    var sIndex = {};
    
    // helper to hold service endpoint -> service title data
    var _serviceTitles = {};

    var cluster = new L.MarkerClusterGroup({
        showCoverageOnHover: true
    }); 

    $(document).ready(function() {
        
        var map = L.mapbox.map('map', 'metajungle.map-hmyeuylc', {
            scrollWheelZoom: false
        }).setView([23, -95], 3);
    
        // center on click 
        cluster.on('click', function(e) {
              map.panTo(e.layer.getLatLng());
        });

        map.addLayer(cluster);
        
        // add markers 
        initializeMarkers();
    });    

    function createFilter(items) {
        var fn = function(f) {
            var show = false;
            var ps = f.properties['offering-properties'];
            for (var i = 0; i < items.length; i++) {
                var item = items[i];
                if (ps && ps.indexOf(item.get('uri')) >= 0) {
                    if (!show && item.isOn()) {
                        show = true;
                    }
                }
            }
            return show;
        };
        return fn;
    }
    
    // function indexMarker(feature, marker) {
    //     var ps = feature.properties['offering-properties'];
    //     if (ps) {
    //         for (var i = 0; i < ps.length; i++) {
    //             var p = ps[i];
    //             if (p in pIndex) {
    //                 // push onto existing array 
    //                 pIndex[p].push(marker);
    //             } else {
    //                 // create new array
    //                 pIndex[p] = [marker];
    //             }
    //         }
    //     }
    //     var s = feature.properties['service-endpoint'];
    //     if (s) {
    //         
    //     }
    // }
    
    function indexMarkers(offerings) {
        // clear indexes and data
        pIndex = {};
        sIndex = {};
        _serviceTitles = {}; 
        
        // construct index 
        for (var oId in offerings) {
            var elmt = offerings[oId];
            var feature = elmt.feature;
            var marker = elmt.marker;
            // observed properties 
            var ps = feature.properties['offering-properties'];
            if (ps) {
                for (var i = 0; i < ps.length; i++) {
                    var p = ps[i];
                    if (p in pIndex) {
                        // push onto existing array 
                        pIndex[p].push(elmt);
                    } else {
                        // create new array
                        pIndex[p] = [elmt];
                    }
                }
            }
            // services 
            var s = feature.properties['service-endpoint'];
            if (s) {
                if (s in sIndex) {
                    // push onto existing array 
                    sIndex[s].push(elmt);
                } else {
                    // create new array
                    sIndex[s] = [elmt];
                }
            } 
            // keep track of service titles 
            if (!(s in _serviceTitles)) {
                var title = feature.properties['service-title'];
                if (title) {
                    _serviceTitles[s] = title;
                }
            }
        }
    }
    
    /**
     * TODO: make use of 'allFeatures' to avoid re-fetching  
     *       from backend 
     * 
     * @param _filter used to remove markers before faceted 
     *                search takes place 
     */ 
    function loadFeatures(_callback, _filter) {
        if (allFeatures.length == 0) {
            $.getJSON(geoJSONEndpoint, function(data) {
                // save features 
                allFeatures = data.features; 
                
                _handleFeatures(allFeatures, _filter);
                _callback();
            });         
        } else {
            _handleFeatures(allFeatures, _filter);
            _callback();
        }
        
    }
    
    /**
     * Callback function to update UI elements 
     * 
     */ 
    function updateUI() {
        // update UI

        updateUIProperties();
        updateUIServices(); 
    }
    
    function updateUIProperties() {
        var pList = $("#facet-properties-list");
        // clear
        pList.empty();
        // update
        var ps = Object.keys(pIndex);
        console.log('Props: ' + ps.length);
        $(ps).each(function(idx, val) {
            pList.append(
                '<li data-uri="' + val + '">' + 
                '<span class="op-name">' + util.uriPretty(val) + '</span>' + 
                '<br />' + 
                '<span class="op-uri">' + val + '</span>' + 
                '</li>'
            );
        });
        pList.on('click', 'li', function() {
            // clear previously selected items 
            pList.find('li.active').each(function() {
               $(this).removeClass('active');
            });
           $(this).addClass('active');

           // update facet selection 
           facetSelection['property'] = $(this).data('uri');

           // update based on selection
           updateFeatures(facetSelection);
        });        
    }
    
    function updateUIServices() {
        var sList = $("#facet-services-list");
        // clear
        sList.empty();
        // update
        var ss = Object.keys(sIndex);
        console.log('Services: ' + ss.length);
        $(ss).each(function(idx, val) {
            var title = _serviceTitles[val] ? _serviceTitles[val] : "Untitled";
            sList.append(
                '<li data-uri="' + val + '">' + 
                '<span class="op-name">' + title + '</span>' + 
                '<br />' + 
                '<span class="op-uri">' + val + '</span>' + 
                '</li>'
            );
        });
        sList.on('click', 'li', function() {
            // clear previously selected items 
            sList.find('li.active').each(function() {
               $(this).removeClass('active');
            });
           $(this).addClass('active');

           // update facet selection 
           facetSelection['service'] = $(this).data('uri');

           // update based on selection
           updateFeatures(facetSelection);
        });        
    }    
    
    function _handleFeatures(features, _filter) {
        
        var count = 0;
        
        var markers = {};
        
        for (var i = 0; i < features.length; i++) {
            var f = features[i];
            var geojson = L.geoJson(f, {
                pointToLayer: function(feature, latlng) {
                    var marker = L.marker(latlng, {
                                icon:  L.mapbox.marker.icon({
                                    'marker-color': 'f0f0f0', 
                                    'marker-size': 'small'
                                }), 
                    });
                    
                    var oId = feature.properties['offering-id'];
                    
                    // TODO: add more details 
                    var popup = 
                        '<p>' + oId + '</p>';

                    // add for indexing
                    markers[oId] = {
                        feature: feature, 
                        marker: marker
                    }

                    count++;
   
                    marker.bindPopup(popup, {
                        closeButton: false
                    });
                    return marker;
               }, 
               filter: _filter != undefined ? _filter : null
            });
   
            // add geojson feature/marker to cluster layer 
            cluster.addLayer(geojson);
        }     
        
        // TODO: put into a WebWorker? 
        indexMarkers(markers); 
    }
    
    function updateFeatures(_facets) {

        // clear existing markers 
        cluster.clearLayers();
        
        var indexedElmts = [];
        
        // get the active 'service' facet
        var s = _facets['service'];
        if (s) {
            var ls = sIndex[s];
            if (ls) {
                indexedElmts = indexedElmts.length == 0 ? 
                    indexedElmts.concat(ls) : intersection(ls, indexedElmts);
            }
        }

        // get the active 'observed property' facet
        var p = _facets['property'];
        if (p) {
            var ls = pIndex[p];
            if (ls) {
                indexedElmts = indexedElmts.length == 0 ? 
                    indexedElmts.concat(ls) : intersection(ls, indexedElmts);
                    // 
                // markers = indexedElmts.concat(ls);
            }
        }
        
        var markers = [];
        for (var i = 0; i < indexedElmts.length; i++) {
            var elmt = indexedElmts[i];
            markers.push(elmt.marker);
        }
        
        cluster.addLayers(markers);
        
    }
    
    function getLayers(indexedElmts) {
        var markers = [];
        var offeringIds = [];
        for (var i = 0; i < indexedElmts.length; i++) {
            var elmt = indexedElmts[i];
            var feature = elmt.feature;
            var marker = elmt.marker;
            var oId = feature.properties['offering-id'];
            if (!(oId in offeringIds)) {
                markers.push(marker);
                offeringIds.push(oId);
            }
        }
        return markers;
    }
    
    function intersection(indexElmts1, indexElmts2) {
        var markers = [];
        for (var i = 0; i < indexElmts1.length; i++) {
            var f1 = indexElmts1[i].feature;
            var oId1 = f1.properties['offering-id'];
            for (var j = 0; j < indexElmts2.length; j++) {
                var f2 = indexElmts2[j].feature;
                var marker = indexElmts2[j].marker;
                var oId2 = f2.properties['offering-id'];
                if (oId1 == oId2) {
                    markers.push(marker);
                    break;
                }
            }
        }
        return markers;
    }
    
    function initializeMarkers() {
        loadFeatures(updateUI);
    }    

});
