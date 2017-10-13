(function(window, $) {
  'use strict';

  var disabledButtonClassName = 'usa-button-disabled',
      errorMessageHTML = '<div class="usa-alert usa-alert-error" role="alert"><div class="usa-alert-body"><p class="usa-alert-text">There was a problem determining your location. Please reload the page and try again.</p></div></div>';

  var CoordinatesSearchForm = function(options) {
    this.$container = options.$container;
    this.$latitudeInput = options.$latitudeInput;
    this.$longitudeInput = options.$longitudeInput;
    this.$button = options.$button;
    this.$errorContainer = options.$errorContainer;
    this.$noticeContainer = options.$noticeContainer;

    if (navigator.geolocation) {
      this.setup();
    }
  };

  CoordinatesSearchForm.prototype = {
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
          this.$latitudeInput.val(coords.latitude);
          this.$longitudeInput.val(coords.longitude);

          this.$container.trigger('submit');
        }
      }
    },

    setup: function() {
      this.$button.on('click', this.events.click.bind(this));

      this.$container.add(this.$noticeContainer).removeAttr('hidden');
    }
  };

  var $container = $('#coordinates-search-form');

  if ($container.length) {
    new CoordinatesSearchForm({
      $container: $container,
      $latitudeInput: $('#latitude'),
      $longitudeInput: $('#longitude'),
      $button: $container.find('button'),
      $errorContainer: $('#error-container'),
      $noticeContainer: $('#geolocation-notice')
    });
  }
})(window, jQuery);
