App = Ember.Application.create();

App.Router.map(function() {
  // put your routes here
  this.resource('facet');
});

App.FacetRoute = Ember.Route.extend({
  setupController: function (controller, model) {
    Ember.Instrumentation.subscribe("facet.properties.set", {
      before: function(name, timestamp, payload) {
        // console.log('Recieved ', name, ' at ' + timestamp + ' with payload: ', payload);
        controller.send('updateProperties', payload);
      },
      after: function() {}
    });
  }
});

App.FacetController = Ember.ArrayController.extend({
    content: null,
    init: function() {
        this._super();
        var items = Ember.A();
        return this.set('content', items);
    }, 
    lookupItemController: function(object) {
        return object.get('type');
    },
    updateProperties: function(properties) {
        if (Object.prototype.toString.call(properties) === '[object Array]') {
            var newItems = [];
            var items = this.get('content'); 
            if (items.length > 0) {
                // for (var i = 0; i < properties.length; i++) {
                //     var p = properties[i];
                //     for (var j = 0; j < items.length; j++) {
                //         var item = items[j];
                //         if (p['uri'] == item['uri'] && p['name'] == item['name']) {
                //             newItems.pushObject(item); 
                //         }
                //     }
                // }
                // this.set('content', newItems);
            } else {
                for (var i = 0; i < properties.length; i++) {
                    var p = properties[i];
                    this.pushObject(App.Property.create({
                        name: p['name'],
                        uri: p['uri']
                    }));
                }
            }
                
            //     // TODO: do not add existing properties 
            //     
            //     this.pushObject(App.Property.create({
            //         name: p['name'],
            //         uri: p['uri']
            //     }));
            // }
        }
    }, 
    tap: function(o) {
        var items = this.get('content');
        console.log('Hello from controller: ' + o.get('name'));
        // console.log('Items: ' + items.length); 
        if (o.isOn()) {
            // console.log('Nothing to do');
            return;
        }
        property = o.get('uri');
        for (var i = 0; i < items.length; i++) {
            // true if this item, false otherwise
            // compare by type only 
            if (items[i].get('type') == o.get('type')) {
                // console.log(items[i] == 0 ? "TRUE" : "FALSE");
                items[i].setOn(items[i] == o)
            }
        }
        // for (var i = 0; i < items.length; i++) {
        //     var item = items[i];
        //     if (item.isOn()) {
        //         console.log('Filter by: ' + item.get('name'));
        //     }
        // }
        o.tap();

        updateMarkers(createFilter(this.get('content')));

        $("#btn-clear-property").removeClass('pure-button-disabled');
    }, 
    create: function() {
        this.pushObject(App.Test.create({
            name:'New object', 
            type: 'service', 
            on: false
        })); 
    }, 
    createService: function() {
        this.pushObject(App.Service.create({
            name:'New service', 
        })); 
    }, 
    createProperty: function() {
        this.pushObject(App.Property.create({
            name:'New property', 
        })); 
    }, 
    remove: function(o) {
        this.removeObject(o);
    }, 
    clear: function() {
        var items = this.get('content');
        for (var i = 0; i < items.length; i++) {
            items[i].setOn(false);
        }
        updateMarkers();
    }
});

App.ServiceController = Ember.ObjectController.extend({
    isService: function() {
        return true;
    }
});

App.PropertyController = Ember.ObjectController.extend({
    isProperty: function() {
        return true;
    }
});


App.Facet = Ember.Object.extend({
    tap: function() {
        // console.log('Hi from the object: ' + this.get('name'));
    }, 
    setOn: function(status) {
        this.set('on', status);
    },
    isOn: function() {
        return this.get('on');
    }
});

App.Service = Ember.Object.extend({
    name: 'Untitled service', 
    type: 'service', 
    endpoint: '', 
    on: false, 
    tap: function() {
        // console.log('Hi from SERVICE: ' + this.get('name'));
    }, 
    setOn: function(status) {
        this.set('on', status);
    },
    isOn: function() {
        return this.get('on');
    }
});

App.Property = Ember.Object.extend({
    name: 'Untitled property', 
    type: 'property', 
    uri: '', 
    on: false, 
    tap: function() {
        // console.log('Hi from PROPERTY: ' + this.get('name'));
    }, 
    setOn: function(status) {
        this.set('on', status);
    },
    isOn: function() {
        return this.get('on');
    }
});
