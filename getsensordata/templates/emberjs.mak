<!DOCTYPE html>
<html>
    <head>
        <title>Discover sensor data</title>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no' />
  
        <script src='http://api.tiles.mapbox.com/mapbox.js/v1.3.0/mapbox.js'></script>
        <script src="/static/leaflet.markercluster/leaflet.markercluster.js"></script>

        <script data-main="/static/js/main" src="/static/js/require.js"></script>

        <!-- <script src="/static/bootstrap/js/bootstrap.min.js"></script> -->
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
    
    <div id="map">
        <p style="text-align: center;">Loading...</p>
    </div>

    <div id="main">
        
        <div class="pure-g-r">

            <div class="pure-u-1-2">
                <div id="facet-properties" class="facet-column">
                    <button id="btn-facet-clear-properties" class="pure-button pure-button-warning">
                      <i class="icon icon-remove icon-white"></i> Clear
                    </button>
                    <ul id="facet-properties-list" class="list">
                        <!-- placeholder -->
                    </ul>
                </div>
            </div>
            <div class="pure-u-1-2">
                <div id="facet-services" class="facet-column">
                    <button id="btn-facet-clear-services" class="pure-button pure-button-warning">
                      <i class="icon icon-remove icon-white"></i> Clear
                    </button>
                    <ul id="facet-services-list" class="list">
                        <!-- placeholder -->
                    </ul>
                </div>
            </div>

        </div>
        
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    </div>
    
</body>
</html>
