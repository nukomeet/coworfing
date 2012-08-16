class C.MapView extends Backbone.View
  el: $('#mapino')
  
  initialize: ->
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
