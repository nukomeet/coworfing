//this function includes all necessary js files for the application
function include(file)
{
 
  var script  = document.createElement('script');
  script.src  = file;
  script.type = 'text/javascript';
  script.defer = true;
 
  document.getElementsByTagName('head').item(0).appendChild(script);
 
}
 
/* include any js files here */
include('/assets/markerclusterer.js');

var markers = [];
var map = null;

var imageUrl = 'http://chart.apis.google.com/chart?cht=mm&chs=24x32&chco=FFFFFF,008CFF,000000&ext=.png';
var markerImage = new google.maps.MarkerImage(imageUrl, new google.maps.Size(24, 32));

$(function () {
    var user_location = "";

    user_location = $.parseJSON(
        $.ajax({
            type: 'GET',
            url: '/home/location',
            dataType: 'json',
            success: function () { },
            data: {},
            async: false
        }).responseText
    );

    map = new google.maps.Map(document.getElementById('mapino'), {
            zoom: 3,
            center: new google.maps.LatLng(45.52527, -73.604043),
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            minZoom: 3
        });


    $.getJSON("/map", { limit: 150 }, function (json) {
        if (json.length > 0) {
            for (i = 0; i < json.length; i++) {
                var place = json[i];
                addLocation(place);
            }

            var markerClusterer = new MarkerClusterer(map, markers, {
                maxZoom: 18,
                gridSize: 30,
		style: null
            });
        }
    });

    function addLocation(place) {

        var latLng = new google.maps.LatLng(place.latitude, place.longitude);
        var marker = new google.maps.Marker(
            { 
                position: latLng,
                draggable: true,
                clickable: true,
                map: map,
                title: place.name,
                icon: markerImage
            });

        var info = new google.maps.InfoWindow({
            content: "<strong>" + place.name + "</strong><br/><br/><a href='/places/" + place.id + "' class='btn btn-info'>View details »</a>"
            });

        google.maps.event.addListener(marker, 'click', function() {
            info.open(map, marker);
        });

        markers.push(marker);
    }
});
