<!DOCTYPE html>
<html>
<head>
  <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no' />
  
  <!--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" ></script>-->
  
  <script src="/static/js/libs/jquery-1.9.1.js"></script>
  
  <script src='http://api.tiles.mapbox.com/mapbox.js/v1.1.0/mapbox.js'></script>
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
        <div class="tabbable"> <!-- Only required for left/right tabs -->
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab1" data-toggle="tab">Services</a></li>
            <li><a href="#tab2" data-toggle="tab">Observed properties</a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane" id="tab1">
              <p>
                  <button class="pure-button pure-button-small" href="#">
                      <span class="op-name">National Data Buoy Center</span>
                      <br />
                      <span class="op-uri">http://sdf.ndbc.noaa.gov/sos/server.php</span>
                  </button>
                  <button class="pure-button pure-button-small" href="#">
                      <span class="op-name">PacIOOS</span>
                      <br />
                      <span class="op-uri">http://www.google.com/waves</span>
                  </button>
              </p>
            </div>
            <div class="tab-pane active" id="tab2">
              <p>
              <button id="test">Test</button>
              </p>
              <p>
                <button id="btn-clear-property" class="pure-button pure-button-warning pure-button-disabled">
                  <i class="icon icon-remove icon-white"></i> Clear filter
                </button>
              </p>
              <p>
                  <button class="pure-button btn-filter-property" data-uri="http://mmisw.org/ont/cf/parameter/air_temperature">
                      <span class="op-name">Air Temperature</span>
                      <br />
                      <span class="op-uri">http://mmisw.org/ont/cf/parameter/air_temperature</span>
                  </button>
                  <button class="pure-button btn-filter-property" data-uri="http://mmisw.org/ont/cf/parameter/air_pressure_at_sea_level">
                      <span class="op-name">Air Pressure At Sea Level</span>
                      <br />
                      <span class="op-uri">http://mmisw.org/ont/cf/parameter/air_pressure_at_sea_level</span>
                  </button>
              </p>
            </div>
          </div>
        </div>
        
        {{outlet}}
        
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </div>
    </script>
    
    <script type="text/x-handlebars" data-template-name="index/_ops">
        {{#each model}}
        <button class="pure-button btn-filter-property">
            <span class="op-name">{{name}}</span>
            <br />
            <span class="op-uri">{{uri}}</span>
        </button>
        {{/each}}
    </script>
    
    <script type="text/x-handlebars" id="properties">
    <p>
    {{#each App.propertiesController}}
        {{view App.myView this}}
    {{/each}}
    </p>
    </script> 
    
    <script type="text/x-handlebars" id="properties2">
    <p>
    {{#each App.propertiesController}}
    <button class="pure-button {{#if active}}pure-button-secondary{{else}}pure-button-disabled{{/if}} btn-filter-property">
        <span class="op-name">{{name}}</span>
        <br />
        <span class="op-uri">{{uri}}</span>
    </button>
    {{/each}}
    </p>
    </script> 
    
    <script type="text/x-handlebars" data-template-name="index">
        {{#each model}}
        <a class="pure-button btn-filter-property {{#if isActive}}pure-button-secondary{{else}}pure-button-disabled{{/if}}">
            <span class="op-name">{{name}}</span>
            <br />
            <span class="op-uri">{{uri}}</span>
        </a>
        {{/each}}
    </script>

    <script type="text/x-handlebars" data-template-name="about">
      <ul>
      {{#each model}}
        <li>{{name}}</li>
      {{/each}}
      </ul>
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
            // TODO: to implement
        }
        return value;
    }
    
    function loadMarkers(_filter) {
        
        $.getJSON('/static/geojson/ndbc.geojson', function(data) {
            markers.clearLayers();
            var props = [];
            var geojson = L.geoJson(data.features, {
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
                    
                    marker.bindPopup(popup, {
                        closeButton: false
                    });
                    return marker;
                }, 
                filter: _filter ? _filter : function(f) { return true; }
            }).addTo(markers); 
            
            // add properties
            for (var i = 0; i < props.length; i++) {
                var p = props[i];
                App.propertiesController.add(uriPretty(p), p);
            }
        });
    }
    
    $(document).ready(function() {
        
        var map = L.mapbox.map('map', 'examples.map-4l7djmvo', {
            scrollWheelZoom: false
        }).setView([23, -95], 3);
    
        $("#test").click(function() {
            // App.OP.FIXTURES.clear();
            // for (r in App.OP.find()) {
            //     r.deleteRecord();
            // }
            App.propertiesController.add('My property', 'http://www.google.com');
            // App.OP.createRecord({
            //     id: 2,
            //     name: 'Hello!',
            //     uri: 'http://www.google.com'
            // });
            //App.OP.FIXTURES = [{'id':2, 'name':'Hello', 'uri':'http://www.google.com'}];
        });
    
        // clear properties filters
        $("#btn-clear-property").click(function() {
            var cls = 'pure-button-secondary';
            $(".btn-filter-property").removeClass(cls);
            $("#btn-clear-property").addClass('pure-button-disabled');
            loadMarkers();
        });

        // toggles a properties filter 
        $(".btn-filter-property").click(function() {
            var cls = 'pure-button-secondary';
            $(".btn-filter-property").removeClass(cls);
            $(this).addClass(cls);
            $("#btn-clear-property").removeClass('pure-button-disabled');
            var uri = $(this).data('uri');
            loadMarkers(function(f) {
                var ps = f.properties['offering-properties'];
                if (ps && ps.indexOf(uri) >= 0)
                    return true;
                return false;
            });
        });
        
        $("#select_property li").click(function() {
            $(this).parent().each(function(idx, val) {
               $(this).removeClass('active');
            });
           $(this).addClass('active');
           $("#op-selector-value").text($(this).find(".op-name").text());
           return true;
        });
        
        // var food = document.getElementById('filter-food');
        // var all = document.getElementById('filter-all');

        // food.onclick = function(e) {
        //     all.className = '';
        //     this.className = 'active';
        //     // The setFilter function takes a GeoJSON feature object
        //     // and returns true to show it or false to hide it.
        //     // clusters.setFilter(function(f) {
        //     //     return f.properties['marker-symbol'] === 'fast-food';
        //     // });
        //     loadMarkers(function(f) {
        //         var props = f.properties['Observed properties'];
        //         if (props && props.indexOf("Air Temperature") >= 0)
        //             return true;
        //         // return f.properties['marker-symbol'] === 'fast-food';
        //     });
        //     return false;
        // };

        // all.onclick = function() {
        //     food.className = '';
        //     this.className = 'active';
        //     // clusters.setFilter(function(f) {
        //     //     // Returning true for all markers shows everything.
        //     //     return true;
        //     // });
        //     loadMarkers();
        //     return false;
        // };        
  
        // $.getJSON('/static/geojson/ndbc.geojson', function(data) {
        //   
        //     clusters = new L.MarkerClusterGroup({
        //         showCoverageOnHover: true
        //     });
        // 
        //     var points = L.geoJson(data.features, {
        //         pointToLayer: function(feature, latlng) {
        //             var marker = 
        //                 L.marker(latlng, {
        //                         icon:  L.mapbox.marker.icon({
        //                             // 'marker-symbol': 'post', 
        //                             'marker-color': 'f0f0f0', 
        //                             'marker-size': 'small'
        //                         }), 
        //                 });
        //             var popup = 
        //                 '<p>' + 
        //                 feature.properties['Offering Id'] + 
        //                 '</p>';
        //                 
        //             marker.bindPopup(popup, {
        //                 closeButton: false
        //             });
        //             // clusters.addLayer(marker);
        //             return marker;
        //         }, 
        //     }).addTo(clusters);
        // 
        //     // map.addLayer(clusters);
        //     clusters.on('click', function(e) {
        //           map.panTo(e.layer.getLatLng());
        //     });
        // });
        
        
        // map.addLayer(clusters);
        markers.on('click', function(e) {
              map.panTo(e.layer.getLatLng());
        });
        
        map.addLayer(markers);
        
        loadMarkers();
    });
    
    </script>
    

</body>
</html>
