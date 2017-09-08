var mymap;
var myLocationMarker;
var spinner;

(function(window, $) {
  'use strict';

  var $mapid = $('#mapid');

  // Only run the following on pages which have a map
  if (!$mapid.length)
    return;

  var lat = $mapid.data('originLat');
  var lng = $mapid.data('originLng');

  mymap = L.map('mapid').setView([lat, lng], 4);

  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18
  }).addTo(mymap);

  L.Control.Spinner = L.Control.extend({
    onAdd: function(map) {
        var img = L.DomUtil.create('img');

        img.src = $mapid.data('spinnerPath');
        img.style.width = '200px';

        return img;
    },

    onRemove: function(map) {
        // Nothing to do here
    }
  });

  L.control.spinner = function(opts) {
    return new L.Control.Spinner(opts);
  }

  spinner = L.control.spinner({ position: 'bottomleft' });

  var myIcon = L.icon({
      iconUrl: $mapid.data('markerIconPath'),
      iconRetinaUrl: $mapid.data('markerIcon2xPath'),
      iconAnchor: [17, 48],
      popupAnchor: [0, -48],
      shadowUrl: $mapid.data('markerShadowPath'),
      shadowAnchor: [13, 41]
  });

  // remove existing markers
  for (var marker of markers) {
    marker.remove();
  }
  markers = [];

  // place current markers with links to the corresponding results, and store them for later possible removal
  for (var loc of locations) {
    var marker = L.marker([loc['lat'], loc['lng']], {icon: myIcon, title: loc['name'], riseOnHover: true}).addTo(mymap);
    var anchor = '#' + loc['id'];
    marker.bindPopup('<div class="map-marker-bubble"><span>' + loc["name"] + '</span><a href="' + anchor + '">View Details</a></div>');
    markers.push(marker);
    coordinates.push([loc['lat'], loc['lng']]);
  }

  // zoom the map so that all markers are visible
  if (coordinates.length > 0)
    mymap.flyToBounds(coordinates, { padding: [20, 20]});

  // put the pulsing dot at the origin if the search is by coordinates and not by zip code
  if (location.search.indexOf('coords=') >= 0)
    setMyLocationMarker(lat, lng);

  if (navigator.geolocation) {
    // Geolocation API not supported by this browser
    $('#location-search-mine').removeAttr('hidden');
  }

})(window, jQuery);

function enableLocationSearch() {
  $('#button-search-mine').removeClass('usa-button-disabled');
  spinner.remove();
}

function setMyLocationMarker(lat, lng) {
  var pulseIcon = L.divIcon({className: 'pulse-dot'});
  myLocationMarker = L.marker([lat, lng], {icon: pulseIcon}).addTo(mymap);
}

function getLocation(button) {
  $('#location-error').attr('hidden', '');
  if (myLocationMarker != null)
    myLocationMarker.remove();
  button.className = 'usa-button-disabled';
  spinner.addTo(mymap);

  var options = {
    enableHighAccuracy: false,
    timeout: 5000,
    maximumAge: 0
  };
  navigator.geolocation.getCurrentPosition(showPosition, getLocationError, options);
}

function showPosition(position) {
  enableLocationSearch();
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;

  // center the map on the location and zoom to something reasonable, re-zoom later when the search results arrive
  mymap.setView([lat, lng], 13);
  setMyLocationMarker(lat, lng);

  // search for nearest offices / weigh stations
  location.href = location.pathname + '?coords=' + lat + ',' + lng + '#mapid';
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

  $('#location-error-body').text(message);
  $('#location-error').removeAttr('hidden');
  enableLocationSearch();
}
