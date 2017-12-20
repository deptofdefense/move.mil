(function(window, $) {
  'use strict';

  var LocatorMapMarker = function(options) {
    this.$container = options.$container;
    this.id = options.id;
    this.name = options.name;
    this.latitude = options.latitude;
    this.longitude = options.longitude;
    this.icon = options.icon;

    this.setup();
  };

  LocatorMapMarker.prototype = {
    setup: function() {
      this.marker = L.marker([this.latitude, this.longitude], {
        alt: 'Map marker for ' + this.name,
        icon: this.icon,
        riseOnHover: true,
        title: this.name
      });

      this.marker.bindPopup('<div class="map-marker-bubble"><b>' + this.name + '</b><a href="#' + this.id + '">View Details</a></div>');
    }
  };

  var LocatorMap = function(options) {
    this.$container = options.$container;
    this.$locations = options.$locations;

    var iconDefaults = {
      iconAnchor: [17, 48],
      popupAnchor: [0, -48],
      shadowUrl: this.$container.data('markerShadowPath'),
      shadowAnchor: [13, 41]
    };

    this.icons = {
      'transportation-office': L.icon($.extend({}, iconDefaults, {
        iconUrl: this.$container.data('markerTransportationOfficeIconPath'),
        iconRetinaUrl: this.$container.data('markerTransportationOfficeIcon2xPath')
      })),

      'weight-scale': L.icon($.extend({}, iconDefaults, {
        iconUrl: this.$container.data('markerWeightScaleIconPath'),
        iconRetinaUrl: this.$container.data('markerWeightScaleIcon2xPath')
      }))
    };

    this.map = L.map(this.$container.attr('id'), {
      maxZoom: 18,
      scrollWheelZoom: false
    });

    this.markers = [];

    this.setup();
    this.addMarkers();
    this.fitToBounds();
  };

  LocatorMap.prototype = {
    addMarkers: function() {
      for (var i = 0, j = this.markers.length; i < j; i++) {
        this.markers[i].marker.addTo(this.map);
      }
    },

    fitToBounds: function() {
      var coordinates = [];

      for (var i = 0, j = this.markers.length; i < j; i++) {
        var marker = this.markers[i];

        coordinates.push([marker.latitude, marker.longitude]);
      }

      if (coordinates.length) {
        this.map.flyToBounds(coordinates, {
          padding: [20, 20]
        });
      }
    },

    removeMarkers: function() {
      for (var i = 0, j = this.markers.length; i < j; i++) {
        this.markers[i].marker.remove();
      }
    },

    setup: function() {
      var latitude = this.$container.data('latitude'),
          longitude = this.$container.data('longitude');

      this.map.setView([latitude, longitude], 8);

      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: 'Map data © <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors. Map imagery © <a href="https://www.mapbox.com">Mapbox</a>.'
      }).addTo(this.map);

      this.$locations.each(function(index, element) {
        var $location = $(element);

        this.markers.push(new LocatorMapMarker({
          $container: $location,
          icon: this.icons[$location.data('type')],
          id: $location.attr('id'),
          name: $location.data('name'),
          latitude: $location.data('latitude'),
          longitude: $location.data('longitude')
        }));
      }.bind(this));

      L.marker([latitude, longitude], {
        alt: '',
        icon: L.divIcon({
          className: 'map-marker-pulse'
        })
      }).addTo(this.map);
    }
  };

  var $container = $('#locator-map');

  if ($container.length) {
    new LocatorMap({
      $container: $container,
      $locations: $('#search-results .location-search-result')
    });
  }
})(window, jQuery);
