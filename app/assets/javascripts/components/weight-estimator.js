(function(window, $) {
  'use strict';

  var CoordinatesSearchForm = function(options) {
    this.$container = options.$container;
    this.$button = options.$button;
    this.$quantityInputs = options.$quantityInputs;
    this.$weightResult = options.$weightResult;

    this.setup();
  };

  CoordinatesSearchForm.prototype = {
    events: {
      click: function(event) {
        event.preventDefault();

        var sum = 0;
        this.$quantityInputs.each(function() {
          var $input = $(this);
          if ($input.val() > 0) {
            var $weightInput = $('#' + this.id + '_weight');
            sum += $input.val() * $weightInput.val();
          }
        });

        this.$weightResult.html(sum + " lbs");
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
      $button: $('#calcuate-button'),
      $quantityInputs: $container.find('.hhg-quantity-input'),
      $weightResult: $('#weight-result')
    });
  }
})(window, jQuery);
