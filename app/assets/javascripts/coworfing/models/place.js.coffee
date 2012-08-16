class C.Place extends Backbone.Model

class C.Places extends Backbone.Collection
  url: '/places'
  model: C.Place
