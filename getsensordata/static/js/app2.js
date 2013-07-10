App = Ember.Application.create();

App.Router.map(function() {
  // put your routes here
  this.resource('test');
});

App.TestController = Ember.ArrayController.extend({
    content: null,
    init: function() {
        this._super();
        var items = Ember.A();
        // initialize 
        // items.pushObject(App.Test.create({
        //     name: 'NDBC', 
        //     active: true, 
        //     type: 'service', 
        //     endpoint: 'http://sdf.ndbc.noaa.gov/sos/server.php'
        // }));
        // items.pushObject(App.Test.create({
        //     name: 'Air temperature', 
        //     active: false, 
        //     type: 'property', 
        //     uri: 'http://mmisw.org/ont/cf/parameter/air_temperature'
        // }));
        return this.set('content', items);
    }, 
    
    lookupItemController: function(object) {
        // return object.get('type');
        if (object.get('type') == 'service') {
            return 'service';
        }
        return 'property';
        // return 'service';
    },     
    
    tap: function(o) {
        var items = this.get('content');
        console.log('Hello from controller: ' + o.get('name'));
        console.log('Items: ' + items.length); 
        if (o.isOn()) {
            console.log('Nothing to do');
            return;
        }
        for (var i = 0; i < items.length; i++) {
            // true if this item, false otherwise
            // compare by type only 
            if (items[i].get('type') == o.get('type')) 
                items[i].setOn(items[i] == o)
        }
        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            if (item.isOn()) {
                console.log('Filter by: ' + item.get('name'));
            }
        }
        o.tap();
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
            // type: 'service', 
            // active: false
        })); 
    }, 
    createProperty: function() {
        this.pushObject(App.Property.create({
            name:'New property', 
            // type: 'property', 
            // active: false
        })); 
    }, 
    remove: function(o) {
        console.log('Delete')
        this.removeObject(o);
    }
});

App.ServiceController = Ember.ObjectController.extend({
    // name: 'A Service!', 
    isService: function() {
        return true;
    }
});

App.PropertyController = Ember.ObjectController.extend({
    // name: 'A Property!', 
    isProperty: function() {
        return true;
    }
});


App.Test = Ember.Object.extend({
    tap: function() {
        console.log('Hi from the object: ' + this.get('name'));
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
    on: false, 
    tap: function() {
        console.log('Hi from SERVICE: ' + this.get('name'));
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
    on: false, 
    tap: function() {
        console.log('Hi from PROPERTY: ' + this.get('name'));
    }, 
    setOn: function(status) {
        this.set('on', status);
    },
    isOn: function() {
        return this.get('on');
    }
});

// App.Test.reopenClass({
//     active: null, 
//     name: null,
//     uri: null, 
// });
// 
// App.Test.reopenClass({
//     all: function() {
//         var items = [];
//         items.pushObject(App.Test.create({name: 'Hello', active: true}));
//         items.pushObject(App.Test.create({name: 'Hello again!', active: false}));
//         return items;
//     }
// });
// 
// App.TestRoute = Ember.Route.extend({
//     model: function() {
//         return App.Test.all();
//     }
// });
