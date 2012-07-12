


$(function() { 
    if ($('body.home_map').length > 0 || $('body.home_index').length > 0) {
        var user_location = "";

        user_location = $.parseJSON(
            $.ajax({
                  type: 'GET',
                  url: '/home/location'.text(),
                  dataType: 'json',
                  success: function() { },
                  data: {},
                  async: false
            }).responseText
        );

        $('#mapino').gMap({
            address: user_location.city + ", " + user_location.country,
            zoom: 12 
        });


        $.getJSON("/map", { limit: 150 }, function(json) {
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
                    content: "<strong>" + place.name + "</strong><br/><br/><a href='/places/" + place.id + "' class='btn btn-info'>View details »</a>"
                });
        }
    }
});
