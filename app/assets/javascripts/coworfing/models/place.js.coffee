class C.Place extends Backbone.Model
  url:  () ->
    this.collection.url+'/' + this.get("slug")

class C.Places extends Backbone.Collection
  url: '/places'
  model: C.Place
