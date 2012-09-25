class C.NewPlaceView extends Backbone.View
  el: $('#place_form')
  
  initialize: ->
    _.bindAll @
    
    searchMapOptions = {
      map: "#geo_map"
      details: ".details"
      detailsAttribute: "data-geo"
      mapOptions: {
        scrollwheel: true
      }
    }
    
    @.search_field = @.$el.find("#geocomplete").geocomplete(searchMapOptions)
    @.search_field.bind("geocode:result", @.fill_form)
    
  
  fill_form: (event, result) =>
    len = result.address_components.length - 1
    country = result.address_components[len].long_name
    @.$el.find('#place_country').select(country).trigger("liszt:updated")
   
    switch result.address_components[0].types[0]
      when "street_number" then @.$el.find("#place_address_line1").val(result.address_components[1].long_name + " " + result.address_components[0].long_name)
      when "route" then @.$el.find("#place_address_line1").val(result.address_components[0].long_name)
