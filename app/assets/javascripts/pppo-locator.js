(function(window, $) {
  'use strict';

  var $mapid = $('#mapid');

  // Only run the following on pages which have a map
  if (!$mapid.length)
    return;

  var mymap = L.map('mapid').setView([51.505, -0.09], 13);

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

})(window, jQuery);
