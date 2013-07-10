App = Ember.Application.create();

App.Router.map(function() {
  // put your routes here
  this.resource('properties');
});

App.Store = DS.Store.extend({
  revision: 12,
  adapter: 'DS.FixtureAdapter'
  // adapter: DS.RESTAdapter.extend({
  //   url: 'http://localhost:3000'
  // })
});

App.Properties = Ember.Object.extend({
    active: null, 
    name: null,
    uri: null
});

App.AllRoute = Ember.Route.extend({
  model: function() {
    return App.Post.find();
  }
});

// App.PropertiesRoute = Ember.Route.extend({
//   // model: function() {
//   //     return App.Properties.find();
//   // }
// });

App.IndexRoute = Ember.Route.extend({
  model: function() {
      return App.Properties.find();
    // return ['red', 'yellow', 'blue'];
  }
});

App.MyView = Ember.View.extend({
   tagName: 'button', 
   classNames: ['pure-button', 'btn-filter-property']
});

App.myView = App.MyView.create();

App.PropertiesController = Ember.ArrayController.extend({
    content: null,
    init: function() {
        this._super();
        return this.set('content', Ember.A());
    }, 
    add: function (name, uri) {
        var p = App.Properties.create({
            active: true, 
            name: name,
            uri: uri
        });
        this.pushObject(p);
    },
    remove: function (p) {
        this.removeObject(p);
    },
    clear: function() {
        this.set('content', Ember.A());
    }, 
    toggle: function(o) {
        o.set('active', true);
        console.log('clicked...');
        // alert(o['name']);
    }
});

App.propertiesController = App.PropertiesController.create();

App.PropertiesRoute = Ember.Route.extend({
   model: function() {
       return App.propertiesController.find(function() { 
           return true; 
       });
   }
});

// App.PropertiesController = Ember.ObjectController.extend({
//     isActive: false,
//     toggle: function() {
//         this.set('isActive', !this.get('isActive')); 
//     }
// });

App.OPController = Ember.ObjectController.extend({
  isActive: false,

  toggle: function() {
      this.set('isActive', !this.get('isActive'));
  }

  // deactivate: function() {
  //   this.set('isActive', false);
  //   //this.get('store').commit();
  // }
});


// App.Properties = DS.Model.extend({
//     name: DS.attr('string'),
//     uri: DS.attr('string')
// });

//App.OP.FIXTURES = [];
// App.Properties.FIXTURES = [{'id':1, 'name':'Test2', 'uri':'http://www.yahoo.com'}];