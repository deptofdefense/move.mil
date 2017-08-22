var mymap;

(function(window, $) {
  'use strict';

  var $mapid = $('#mapid');

  // Only run the following on pages which have a map
  if (!$mapid.length)
    return;

  mymap = L.map('mapid').setView([51.505, -0.09], 12);

  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18
  }).addTo(mymap);

  var myIcon = L.icon({
      iconUrl: $mapid.data('markerIconPath'),
      iconRetinaUrl: $mapid.data('markerIcon2xPath'),
      shadowUrl: $mapid.data('markerShadowPath')
  });

  L.marker([51.5, -0.09], {icon: myIcon}).addTo(mymap)
    .bindPopup('A pretty CSS3 popup.<br> Easily customizable.')
    .openPopup();

  if (!navigator.geolocation) {
    // Geolocation API not supported by this browser
    $('#my-location-search-section').hide();
  }

})(window, jQuery);

function getLocation() {
  navigator.geolocation.getCurrentPosition(showPosition, getLocationError);
}

function showPosition(position) {
  var lat = position.coords.latitude;
  var lon = position.coords.longitude;

  // center the map on the location and zoom to something reasonable, re-zoom later when the search results arrive
  mymap.setView([lat, lon], 12);

  // search for nearest offices / weigh stations
}

function getLocationError(error) {
  var message;

  switch(error.code) {
  case error.PERMISSION_DENIED:
    /*
     * Permission denied can happen in two cases - the user denied permission to the page,
     * or the page is running in an insecure context on Chrome >= 50. To distinguish
     * between these two possibilities, look at the error message. Kinda brittle, but
     * it's what Google themselves recommend.
     */
    if (error.message.indexOf('Only secure origins are allowed') == 0) {
      message = 'Cannot get your location without an HTTPS connection.';
    } else {
      message = 'Permission denied; please allow this site to get your location and try again.';
    }
    break;
  case error.POSITION_UNAVAILABLE:
    message = 'Could not get the current location.';
    break;
  case error.TIMEOUT:
    message = 'The request to get the current location timed out.';
    break;
  case error.UNKNOWN_ERROR:
  default:
    message = 'An unknown error occurred.';
    break;
  }

  $('#location-error-text').text(message);
}
