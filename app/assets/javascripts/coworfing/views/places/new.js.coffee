class C.NewPlaceView extends Backbone.View
  el: $('#place_form')
  
  initialize: ->
    _.bindAll @, "addFields", "removeFields"
    
    searchMapOptions = {
      map: "#geo_map"
      details: ".details"
      detailsAttribute: "data-geo"
      mapOptions: {
        scrollwheel: true
      }
    }
    
    @.search_field = @.$el.find("#geocomplete").geocomplete(searchMapOptions)
    @.search_field.bind("geocode:result", @.fillForm)
    
  events:
    "click .add_fields" : "addFields"
    "click .remove_fields" : "removeFields"
    
  
  fillForm: (event, result) =>
    len = result.address_components.length - 1
    country = result.address_components[len].long_name
    @.$el.find('#place_country').select(country).trigger("liszt:updated")
   
    switch result.address_components[0].types[0]
      when "street_number" then @.$el.find("#place_address_line1").val(result.address_components[1].long_name + " " + result.address_components[0].long_name)
      when "route" then @.$el.find("#place_address_line1").val(result.address_components[0].long_name)
      
    
  addFields: (event) =>
    event.preventDefault()
    element = $(event.currentTarget)
    time = new Date().getTime()
    regexp = new RegExp(element.data("id"), "g")
    $(".photo-item").last().after element.data("fields").replace(regexp, time)
      

  removeFields: (event) =>
    event.preventDefault()
    element = $(event.currentTarget)
    element.parents(".controls").find(".photo_destroy").val "1"
    element.closest(".photo-item").hide()


