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
        items.pushObject(App.Test.create({name: 'First item', active: true}));
        return this.set('content', items);
    }, 
    tap: function(o) {
        var items = this.get('content');
        console.log('Hello from controller: ' + o.get('name'));
        console.log('Items: ' + items.length); 
        for (var i = 0; i < items.length; i++) {
            // true if this item, false otherwise 
            items[i].setActive(items[i] == o)
        }
        o.tap();
    }, 
    create: function() {
        this.pushObject(App.Test.create({name:'New object', active: false})); 
        outer();
    }, 
    remove: function(o) {
        this.removeObject(o);
    }
});

App.Test = Ember.Object.extend({
    tap: function() {
        console.log('Hi from the object: ' + this.get('name'));
    }, 
    setActive: function(status) {
        this.set('active', status);
    }
});

// App.Test.reopenClass({
//     active: null, 
//     name: null,
//     uri: null, 
// });

// App.Test = Ember.Object.extend({
// App.Test.reopenClass({
//     // active: null, 
//     // name: null,
//     // uri: null
//     all: function() {
//         var items = [];
//         items.pushObject(App.Test.create({name: 'Hello'}));
//         items.pushObject(App.Test.create({name: 'Hello again!'}));
//         return items;
//     }
// });

// App.TestRoute = Ember.Route.extend({
//     // model: function() {
//     //     return App.Test.all();
//     // }
// });
