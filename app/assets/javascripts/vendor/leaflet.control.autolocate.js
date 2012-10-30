L.Control.Autolocate = L.Control.extend({
  includes: L.Mixin.Events,
  
  options: {
    position: 'topleft'
  },
  
  initialize: function(options) {
     L.Util.setOptions(this, options);
  },
    
  onAdd: function (map) {
    var className = 'leaflet-autolocate-control', 
        container = L.DomUtil.create('div', className);
    this._map = map;
    this._createButton("Find places near you!", 'btn btn-danger', container, this.autolocate, this);
    
    return container;
  },
  
  autolocate: function() {
    this._map.locate({setView: true, maxZoom: 16});
  },

	_createButton: function (title, className, container, fn, context) {
		var link = L.DomUtil.create('a', className, container);
		link.href = '#';
		link.title = title;
    link.innerHTML = "<i class='icon-globe'></i>"
    
		L.DomEvent
			.on(link, 'click', L.DomEvent.stopPropagation)
			.on(link, 'click', L.DomEvent.preventDefault)
			.on(link, 'click', fn, context)
			.on(link, 'dblclick', L.DomEvent.stopPropagation);

		return link;
	}

});
