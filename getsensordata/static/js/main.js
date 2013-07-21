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

    var pIndex = {};

    // temp
    var property;


    var allLayers = []; 
    var all = [];
    
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
    
    function indexMarker(feature, marker) {
        var ps = feature.properties['offering-properties']
        if (ps) {
            for (var i = 0; i < ps.length; i++) {
                var p = ps[i];
                if (p in pIndex) {
                    // push onto existing array 
                    pIndex[p].push(marker);
                } else {
                    // create new array
                    pIndex[p] = [marker];
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
    
    function updateUI() {
        // update UI
        var ps = Object.keys(pIndex);
        console.log('Props: ' + ps.length);
        
        var list = $("#facet-properties-list");
        // clear
        list.empty();
        // update
        // var listItems = [];
        $(ps).each(function(idx, val) {
            list.append(
                '<li data-uri="' + val + '">' + 
                '<span class="op-name">' + util.uriPretty(val) + '</span>' + 
                '<br />' + 
                '<span class="op-uri">' + val + '</span>' + 
                '</li>'
            );
        });
        list.on('click', 'li', function() {
            list.find('li').each(function() {
               $(this).removeClass('on');
            });
           // console.log('Clicked: ' + $(this).text()); 
           $(this).addClass('on');
           
           // TODO: take action 
           // TODO: fix
           property = $(this).data('uri');
           console.log('PR: ' + property);
           updateFeatures();
        });
    }
    
    function _handleFeatures(features, _filter) {
        
        var count = 0;
        
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
                    var popup = 
                        '<p>' + 
                        feature.properties['offering-id'] + 
                        '</p>';

                    // index
                    indexMarker(f, marker); 

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
    }
    
    function updateFeatures(_facets) {

        // clear existing markers 
        cluster.clearLayers();

        // TODO: handle facets 

        var layers = pIndex[property];
        console.log('Indexed layers found: ' + layers.length);
        if (layers) {
            cluster.addLayers(layers);
            // for (var i = 0; i < layers.length; i++) {
            //     var layer = layers[i];
            //     markers.addLayer(layer);
            // }
        }
    
        return;
    }
    
    function initializeMarkers() {
        loadFeatures(updateUI);
    }    

});
