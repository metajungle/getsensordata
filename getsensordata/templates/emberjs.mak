<!DOCTYPE html>
<html>
<head>
  <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no' />
  
  <!--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" ></script>-->
  
  <script src="/static/js/libs/jquery-1.9.1.js"></script>
  
  <script src='http://api.tiles.mapbox.com/mapbox.js/v1.3.0/mapbox.js'></script>
  <script src="/static/leaflet.markercluster/leaflet.markercluster.js"></script>

  <script src="/static/bootstrap/js/bootstrap.min.js"></script>
  <script src="/static/js/uri.min.js"></script>
  
  <link rel='stylesheet' 
        href='http://api.tiles.mapbox.com/mapbox.js/v1.1.0/mapbox.css'  />
  <link rel="stylesheet" href="/static/leaflet.markercluster/MarkerCluster.css" />
  <link rel="stylesheet" href="/static/leaflet.markercluster/MarkerCluster.Default.css" />
  <!--[if lte IE 8]>
    <link href='http://api.tiles.mapbox.com/mapbox.js/v1.1.0/mapbox.ie.css' rel='stylesheet' >
  <![endif]-->
  
  <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css" />
  <link rel="stylesheet" href="//yui.yahooapis.com/pure/0.2.0/pure-min.css">
  
  <link rel="stylesheet" href="/static/css/normalize.css">
  <link rel="stylesheet" href="/static/css/style.css">
  
  <style>
  </style>
</head>
<body>
    
    <script type="text/x-handlebars">
    <div id="map"></div>

    <div id="main">
        {{outlet}}

        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    </div>
    </script>
    
    <script type="text/x-handlebars" data-template-name="facet">
    <div class="column">
        <button {{action 'clear'}} class="pure-button pure-button-warning">
          <i class="icon icon-remove icon-white"></i> Clear
        </button>
        <ul class="list">
        {{#each controller}}
        {{#if isProperty}}
            <li {{action 'tap' this}}
                {{bindAttr title="uri"}}
                {{bindAttr class="on :button-facet"}}>
                <span class="op-name">{{name}}</span>
                <br />
                <span class="op-uri">{{uri}}</span>
            </li>
        {{/if}}
        {{/each}}
        </ul>
    </div>
    </script>    

    <script src="/static/js/libs/handlebars-1.0.0-rc.4.js"></script>
    <script src="/static/js/libs/ember-1.0.0-rc.6.js"></script>
    <!--<script src="/static/js/libs/ember-data-latest.min.js"></script>-->
    <script src="/static/js/libs/ember-data-0.13.js"></script>
    <script src="/static/js/app.js"></script>
    
    <script type='text/javascript'>

    // var clusters; 
    var markers = new L.MarkerClusterGroup({
        showCoverageOnHover: true
    }); 
    
    function toTitleCase(str) {
        return str.replace(/\w\S*/g, 
            function(txt) {
                return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
            });
    }
    
    function namePretty(value) {
        return toTitleCase(value.replace(/_/g, ' '));
    }
    
    function uriPretty(value) {
        var uri = new URI(value);
        var protocol = uri.protocol();
        if (protocol == 'http') {
            if (uri.fragment() != '') {
                return namePretty(uri.fragment());
            } else {
                return namePretty(uri.filename());
            }
        } else if (protocol == 'urn') {
            var idx = uri.path().lastIndexOf(':');
            if (idx != -1) {
                return namePretty(uri.path().substring(idx + 1));
            }
        }
        return value;
    }
    
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
    
    var features = [];
    var observedProperties = [];
    
    function getFeatures(_callback, _filter) {
         $.getJSON('/static/geojson/all.geojson', function(data) {
             features = data.features; 
             _callback(data.features, _filter);
         });
    }
    
    var pIndex = {};
    
    // temp
    var property;
    
    var allLayers = []; 
    var all = [];
    
    function updateFeatures2(features, _filter) {
        
        // new test 
        markers.clearLayers();

        var layers = pIndex[property];
        if (layers) {
            markers.addLayers(layers);
            // for (var i = 0; i < layers.length; i++) {
            //     var layer = layers[i];
            //     markers.addLayer(layer);
            // }
        }
        
        return;
        
        // var ms = all.splice(0);
        // ms.splice(100,100);
        // all.splice(0,200);
        
        // test
        console.log('Layers: ' + allLayers.length);
        console.log('TEST: ' + markers.hasLayer(allLayers[0]));
        keep = allLayers.slice(0);
        var remove = keep.splice(0,10);
        console.log('Remove: ' + remove.length);
        
        for (var i = 0; i < remove.length; i++) {
            console.log('CONTAINS: ' + markers.hasLayer(remove[i]));
            markers.removeLayer(remove[i]);
        }
        
        return;
        
        // for (var i = 0; i < allLayers.length; i++) {
        //     var l = allLayers[i];
        //     if ()
        //     
        // }
        
        
        // remove - again
        markers.eachLayer(function(l) {
            var found = false;
            for (var i = 0; i < keep.length; i++) {
                var k = keep[i];
                if (k == l) found = true;
            }
            if (!found) markers.removeLayer(l);
        });
        
        return;
        
        // remove 
        var ls = markers.getLayers();
        var toRemove = ls.filter(function(e, idx, array) {
            return !(keep.indexOf(e) > -1);
        });
        for (var i = 0; i < toRemove.length; i++) {
            markers.removeLayer(toRemove[i]);
        }
        // var rm = [];
        // var rm = ls.splice()
        // for (int i = 0; i < ls.length; i++) {
        //     var l = ls[i];
        //     var k = false;
        //     for (int j = 0; j < keep.length; j++) {
        //         if ()
        //     }
        //     if (markers.hasLayer())
        // }
        
        return;
        
        // add
        for (var i = 0; i < keep.length; i++) {
            var k = keep[i];
            if (!markers.hasLayer(k)) {
                markers.addLayer(k);
            }
        }
        
        // var ls = markers.getLayers();
        // for (var j = 0; j < ls.length; j++) {
        //     var keep = false;
        //     for (var i = 0; i < all.length; i++) {
        //         
        //         // var geojson = all[i];
        //         // if (!markers.hasLayer(geojson))
        //         //     markers.addLayer(geojson);
        //         // else
        //         //     markers.removeLayer(geojson);
        //         // all[i].addTo(markers);
        //     }
        //     if (!keep) {
        //         markers.removeLayer(ls[j]);
        //     }
        //     
        // }
        
        return;
        
        for (var i = 0; i < all.length; i++) {
            var geojson = all[i];
            if (!markers.hasLayer(geojson))
                markers.addLayer(geojson);
            else
                markers.removeLayer(geojson);
            // all[i].addTo(markers);
        }
        // markers.addLayers(all);
    }
    
    function updateFeatures(features, _filter) {
        // markers.clearLayers();

        var props = [];
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
                            // if (!props.contains(p)) {
                            //     props.pushObject(p);
                            // }
                        }
                    }
            
                    count++;
            
                    marker.bindPopup(popup, {
                        closeButton: false
                    });
                    return marker;
               }
            });
            
            var l = markers.addLayer(geojson);
            allLayers.push(geojson);
            all.push(geojson);
        }
        
        // markers.eachLayer(function(l) {
        //     allLayers.push(l);
        // });
        
        // console.log('ALL: ' + markers.getLayers().length);
        // allLayers = markers.getLayers();
        console.log('ALL2: ' + allLayers.length);
        
        props = Object.keys(pIndex);
        console.log('Props: ' + props.length);
        
        // add properties
        if (observedProperties.length <= 0) {
            var ps = [];
            for (var i = 0; i < props.length; i++) {
                var p = props[i];
                ps.push({
                    name: uriPretty(p), 
                    uri: p
                }); 
            }
            Ember.Instrumentation.instrument("facet.properties.set", ps);
        }        
        
        return;
        
        console.log('ALL: ' + all.length)
        
        var geojson = L.geoJson(features, {
            pointToLayer: function(feature, latlng) {
                var marker = 
                    L.marker(latlng, {
                            icon:  L.mapbox.marker.icon({
                                'marker-color': 'f0f0f0', 
                                'marker-size': 'small'
                            }), 
                    });
                var popup = 
                    '<p>' + 
                    feature.properties['offering-id'] + 
                    '</p>';
                    
                var ps = feature.properties['offering-properties']
                if (ps) {
                    for (var i = 0; i < ps.length; i++) {
                        var p = ps[i];
                        if (!props.contains(p)) {
                            props.pushObject(p);
                        }
                    }
                }
                
                count++;
                
                marker.bindPopup(popup, {
                    closeButton: false
                });
                return marker;
            }, 
            // TODO: can remove filter, not used? 
            // filter: _filter ? _filter : function(f) { return true; }
            filter: _filter ? _filter : null
        }).addTo(markers); 
        
        console.log('Markers: ' + count);
        
        // add properties
        if (observedProperties.length > 0) {
            
        } else {
            var ps = [];
            for (var i = 0; i < props.length; i++) {
                var p = props[i];
                ps.push({
                    name: uriPretty(p), 
                    uri: p
                }); 
            }
            Ember.Instrumentation.instrument("facet.properties.set", ps);
        }

    }
    
    function updateMarkers(_filter) {
        
        if (features.length == 0) {
            // TODO: can remove _filter argument, not used 
            getFeatures(updateFeatures, _filter); 
        } else {
            updateFeatures2(features, _filter);
        }
    }

    $(document).ready(function() {
        
        var map = L.mapbox.map('map', 'metajungle.map-hmyeuylc', {
            scrollWheelZoom: false
        }).setView([23, -95], 3);
    
        // map.addLayer(clusters);
        markers.on('click', function(e) {
              map.panTo(e.layer.getLatLng());
        });
        
        map.addLayer(markers);
        
        updateMarkers();
    });
    
    </script>
    

</body>
</html>
