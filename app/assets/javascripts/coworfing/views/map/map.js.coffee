class C.MapView extends Backbone.View
  el: $('#map')
  
  initialize: ->    
    @geo_url = 'http://maps.googleapis.com/maps/api/geocode/json'
    
    _.bindAll @
    
    cloudmade = new L.TileLayer("http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png")
    
    mapOptions = {
      zoom: 9
      center: [51.505, -0.09]
      layers: [cloudmade]
    }
    
    @.markers = new L.MarkerClusterGroup()
    @.markersList = []
    
    @.map =  L.map('mapino', mapOptions)
    
    
    @.populate()
    @
    
    
    
  events:
    "click #map_search" : "get_geo_data"
    "submit form" : "prevent_submit"
    
  
  renderMarker: (place) =>	
    if place.get("latitude") and place.get("longitude")
      marker = new L.Marker( new L.LatLng(place.get("latitude"), place.get("longitude")) )
      popup = JST.place_popup({ place: place.toJSON(), url: place.url() })
      
      marker.bindPopup(popup)
      
      @.markersList.push(marker)
      @.markers.addLayer(marker)
    false   
      
  populate: =>
	  @.collection.each (place) =>
	    @.renderMarker(place)  
	  @.map.addLayer(@.markers)
	  false

  get_geo_data: (e) => 
    query = $(@el).find("#place_input").val()
    $.get(
      @geo_url, 
      { address: query, sensor: "false"}, 
      (data) =>
        if data.results.length > 0
          location = data.results[0].geometry.location
          @.map.setView(new L.LatLng(location.lat, location.lng), 10)
      )
      
  prevent_submit: (e) =>
    e.preventDefault()
