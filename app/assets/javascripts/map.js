$(function() { 
    $('#mapino').gMap({
        address: "Paris",
        zoom: 12 
    });


    $.getJSON("/places", { limit: 10 }, function(json) {
        if (json.length > 0) {
            for (i=0; i<json.length; i++) {
                var place = json[i];
                addLocation(place);
            }
        }
    });

    function addLocation(place) { 
        $('#mapino').gMap('addMarker',
            {
                latitude: place.coordinates[1],
                longitude: place.coordinates[0],
                content: "<strong>Some HTML content</strong><br/><br/><a href='/places/" + place._id + "' class='btn btn-info'>Show</a>"
            });
    }
});
