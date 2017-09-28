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
        icon: this.icon,
        riseOnHover: true,
        title: this.name
      });

      this.marker.bindPopup('<div class="map-marker-bubble"><b>' + this.name + '</b><a href="#' + this.id + '">View Details</a></div>');
    }
  };

  var LocatorMap = function(options) {
    this.$container = options.$container;
    this.$offices = options.$offices;

    this.map = L.map(this.$container.attr('id'));
    this.markers = [];

    this.markerIcon = L.icon({
      iconUrl: this.$container.data('markerIconPath'),
      iconRetinaUrl: this.$container.data('markerIcon2xPath'),
      iconAnchor: [17, 48],
      popupAnchor: [0, -48],
      shadowUrl: this.$container.data('markerShadowPath'),
      shadowAnchor: [13, 41]
    });

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
      this.map.setView([this.$container.data('latitude'), this.$container.data('longitude')], 8);

      L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: 'Map data © <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors. Map imagery © <a href="https://www.mapbox.com">Mapbox</a>.',
        maxZoom: 18
      }).addTo(this.map);

      this.$offices.each(function(index, element) {
        var $office = $(element);

        this.markers.push(new LocatorMapMarker({
          $container: $office,
          icon: this.markerIcon,
          id: $office.attr('id'),
          name: $office.data('name'),
          latitude: $office.data('latitude'),
          longitude: $office.data('longitude')
        }));
      }.bind(this));
    }
  };

  var $container = $('#locator-map');

  if ($container.length) {
    new LocatorMap({
      $container: $container,
      $offices: $('#search-results .transportation-office')
    });
  }
})(window, jQuery);
