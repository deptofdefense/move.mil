(function(window, $) {
  'use strict';

  var disabledButtonClassName = 'usa-button-disabled',
      errorMessageHTML = '<div class="usa-alert usa-alert-error" role="alert"><div class="usa-alert-body"><p class="usa-alert-text">There was a problem determining your location. Please reload the page and try again.</p></div></div>';

  var CoordinatesSearch = function(options) {
    this.$container = options.$container;
    this.$button = options.$button;
    this.$errorContainer = options.$errorContainer;
    this.$noticeContainer = options.$noticeContainer;

    this.setup();
  };

  CoordinatesSearch.prototype = {
    events: {
      click: function(event) {
        event.preventDefault();

        this.$button.attr('disabled', true).addClass(disabledButtonClassName);

        navigator.geolocation.getCurrentPosition(this.events.success.bind(this), this.events.error.bind(this), {
          enableHighAccuracy: true,
          maximumAge: 0,
          timeout: 10000
        });
      },

      error: function(error) {
        this.$errorContainer.html(errorMessageHTML);
      },

      success: function(position) {
        var coords = position.coords;

        if (coords) {
          this.$button.removeAttr('disabled');

          location.href = this.$button.data('action') + '/' + coords.latitude + ',' + coords.longitude;
        }
      }
    },

    setup: function() {
      this.$button.on('click', this.events.click.bind(this));

      this.$container.add(this.$noticeContainer).removeAttr('hidden');
    }
  };

  var $container = $('#coordinates-search');

  if (navigator.geolocation && $container.length) {
    new CoordinatesSearch({
      $container: $container,
      $button: $container.find('button'),
      $errorContainer: $('#error-container'),
      $noticeContainer: $('#geolocation-notice')
    });
  }
})(window, jQuery);
