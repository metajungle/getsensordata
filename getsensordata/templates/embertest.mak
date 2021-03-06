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
  #main {
      margin: 50px;
  }
  </style>
</head>
<body>
    
    <script type="text/x-handlebars">
    
    <div id="main">
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

        {{outlet}}
        
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        
    </div>
    </script>
    
    <script type="text/x-handlebars" data-template-name="test">
    <p><button {{action 'createService'}}
    class="pure-button pur-button-small pure-button-secondary">Create service</button></p>
    <p><button {{action 'createProperty'}}
    class="pure-button pur-button-small pure-button-secondary">Create property</button></p>
    
    <div class="tabbable"> 
        <ul class="nav nav-tabs">
            <li class="active"><a href="#tab1" data-toggle="tab">Services</a></li>
            <li><a href="#tab2" data-toggle="tab">Observed properties</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="tab1">
            Services:
            {{#each controller}}
            {{#if isService}}
            <div {{bindAttr class="on :item"}}>
                <p>
                <button {{action 'tap' this}} class="pure-button">{{name}}</button>
                </p>
                <p>
                {{view Ember.TextField valueBinding='name'}}
                </p>
            </div>
            {{/if}}
            {{/each}}
            </div>
            <div class="tab-pane" id="tab2">
            Properties: 
            {{#each controller}}
            {{#if isProperty}}
            <div {{bindAttr class="on :item"}}>
                <p>
                <button {{action 'tap' this}} class="pure-button">{{name}}</button>
                </p>
                <p>
                {{view Ember.TextField valueBinding='name'}}
                </p>
            </div>
            {{/if}}
            {{/each}}
            </div>
        </div>
    </div>
    </script>
    
    <script type="text/x-handlebars" data-template-name="test2">
        <p><button {{action 'createService'}}
        class="pure-button pur-button-small pure-button-secondary">Create service</button></p>
        <p><button {{action 'createProperty'}}
        class="pure-button pur-button-small pure-button-secondary">Create property</button></p>
        <p><button {{action 'create'}}
        class="pure-button pur-button-small pure-button-secondary">Create</button></p>
        <hr />
        {{#each controller}}
        <div {{bindAttr class="active :item"}}>
            <p>
            <button {{action 'tap' this}} class="pure-button">{{name}}</button>
            <button {{action 'remove' this}} 
                    class="pure-button pur-button-small pure-button-error">Remove</button>
            </p>
            {{view Ember.TextField valueBinding='name'}}
        </div>
        {{/each}}
        <hr />
        <p><strong>Services</strong></p>
        {{#each controller}}
        {{#if isService}}
        <p>{{name}}</p>
        {{/if}}
        {{/each}}
    </script>
    
    <script type="text/x-handlebars" data-template-name="index">
        The index
    </script>

    <script src="/static/js/libs/handlebars-1.0.0-rc.4.js"></script>
    <script src="/static/js/libs/ember-1.0.0-rc.6.js"></script>
    <script src="/static/js/libs/ember-data-0.13.js"></script>
    <script src="/static/js/app2.js"></script>
    
    <script type='text/javascript'>

    function outer() {
        console.log('From outer fn...');
    }

    $(document).ready(function() {
        
    });
    
    </script>
    

</body>
</html>
