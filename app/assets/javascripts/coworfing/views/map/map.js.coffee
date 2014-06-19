class C.MapView extends Backbone.View
  el: $('#map')

  initialize: ->
    _.bindAll @

    googleLayer = new L.Google('ROADMAP');

    mapOptions = {
      layers: [ googleLayer ]
      scrollWheelZoom: false
    }

    @search_input = @.$el.find("#place_input")
    @search_input.geocomplete()
    @search_input.bind("geocode:result", @get_geo_data)

    @markers = new L.MarkerClusterGroup({maxClusterRadius: 60})
    @markersList = []

    @map = L.map('mapino', mapOptions)
    L.Icon.Default.imagePath = '../assets/images'
    @map.locate(setView: true, maxZoom:13)

    @map.addControl(new L.Control.Autolocate())

    @populate()
    @

  events:
    "submit form" : "prevent_submit"
    "click #autolocate" : "autolocate"


  renderMarker: (place) =>
    if place.get("latitude") and place.get("longitude")
      marker = new L.Marker( new L.LatLng(place.get("latitude"), place.get("longitude")), { place: place } )

      popup = JST.place_popup({ place: place.toJSON(), url: place.url() })

      marker.bindPopup(popup, {closeButton: false, maxWidth: 140})

      marker.on("mouseover", (e) ->
        this.openPopup()
      )

      marker.on("mouseout", (e) ->
        this.closePopup()
      )

      marker.on("click", (e) ->
        window.open(place.url(), '_blank')
      )

      @markersList.push(marker)
      @markers.addLayer(marker)
    false

  populate: =>
    @collection.each (place) =>
      @renderMarker(place)
    @map.addLayer(@.markers)
    false

  get_geo_data: (e, r) =>
    @map.setView([r.geometry.location.lat(), r.geometry.location.lng()], 10)

  prevent_submit: (e) =>
    @search_input.geocomplete("find", @search_input.val())
    e.preventDefault()

  autolocate: (e) =>
    @map.locate({setView: true, maxZoom: 16})
    e.preventDefault()
