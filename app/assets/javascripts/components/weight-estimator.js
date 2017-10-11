(function(window, $) {
  'use strict';

  var CoordinatesSearchForm = function(options) {
    this.$container = options.$container;
    this.$button = options.$button;
    this.$quantity_inputs = options.$quantity_inputs;
    this.$weight_result = options.$weight_result;

    this.setup();
  };

  CoordinatesSearchForm.prototype = {
    events: {
      click: function(event) {
        var $sum = 0;
        event.preventDefault();
        this.$quantity_inputs.each(function() {
          if (this.value > 0) {
            var $weight = $('#' + this.id + '_weight');
            $sum += this.value * $weight.attr('value');
          }
        });
        this.$weight_result.html($sum + " lbs");
      }
    },

    setup: function() {
      this.$button.on('click', this.events.click.bind(this));
    }
  };

  var $container = $('#weight-estimator-form');

  if ($container.length) {
    new CoordinatesSearchForm({
      $container: $container,
      $button: $container.find('#calcuate-button'),
      $quantity_inputs: $container.find('.hhg-quantity-input'),
      $weight_result: $container.find('#weight-result')
    });
  }
})(window, jQuery);
