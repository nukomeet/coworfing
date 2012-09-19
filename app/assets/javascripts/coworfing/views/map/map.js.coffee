class C.MapView extends Backbone.View
  el: $('#map')
  
  initialize: ->    
    _.bindAll @
    coords = [parseFloat(@options.userLocation.data.latitude), parseFloat(@options.userLocation.data.longitude)]        
    cloudmade = new L.TileLayer("http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png")         
      
    mapOptions = {
      zoom: 9
      center: coords
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
    $.getJSON(
      'home/location',
      { query: query},
      (data) =>
        if data.queryResult isnt null
          location = data.queryResult
          @.map.setView(new L.LatLng(parseFloat(location[0]), parseFloat(location[1])), 10)
    )
          
  prevent_submit: (e) =>
    e.preventDefault()
