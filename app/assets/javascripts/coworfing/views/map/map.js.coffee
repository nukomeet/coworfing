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
    
    @search_input = @.$el.find("#place_input")
    @search_input.geocomplete()
    @search_input.bind("geocode:result", @get_geo_data)
    
    
    @markers = new L.MarkerClusterGroup()
    @markersList = []
    
    @map =  L.map('mapino', mapOptions)
    L.Icon.Default.imagePath = '../assets/images'
    
    @populate()
    @
    
  events:
    "click #map_search" : "get_geo_data"
    "submit form" : "prevent_submit"
    
  
  renderMarker: (place) =>	
    if place.get("latitude") and place.get("longitude")
      marker = new L.Marker( new L.LatLng(place.get("latitude"), place.get("longitude")) )
      popup = JST.place_popup({ place: place.toJSON(), url: place.url() })
      
      marker.bindPopup(popup)
      
      @markersList.push(marker)
      @markers.addLayer(marker)
    false   
      
  populate: =>
	  @collection.each (place) =>
	    @renderMarker(place)  
	  @map.addLayer(@.markers)
	  false

  get_geo_data: (e, r) => 
    @map.setView([r.geometry.location.Xa, r.geometry.location.Ya], 10)
   
  prevent_submit: (e) =>
    e.preventDefault()
