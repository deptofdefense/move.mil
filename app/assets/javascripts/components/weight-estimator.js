(function(window, $) {
  'use strict';

  var WeightEstimator = function(options) {
    this.$container = options.$container;
    this.$categoryButtons = options.$categoryButtons;
    this.$estimateButton = options.$estimateButton;
    this.$weightResult = options.$weightResult;

    this.setup();
  };

  WeightEstimator.prototype = {
    events: {
      clickCategoryButton: function(event) {
        event.preventDefault();

        var $button = $(event.target),
            subtotal = this.calculateWeight($button.closest('.hhg-category')),
            total = this.calculateWeight(this.$container),
            categoryKey = $button.attr('id');

        $('#' + categoryKey + '_subtotal').val(subtotal);
        $('#' + categoryKey + '_total').val(total);
      },

      clickEstimateButton: function(event) {
        event.preventDefault();

        var total = this.calculateWeight(this.$container),
            packingDays = '4 days';

        if (total < 5000) {
          packingDays = '1 day';
        } else if (total < 7000) {
          packingDays = '2 days';
        } else if (total < 9000) {
          packingDays = '3 days';
        }

        this.$weightResult.html(
          '<div>Estimated grand total: ' + total + ' lbs</div>' +
          '<div>Average time to pack ' + total + ' lbs is ' + packingDays + '</div>'
        );
      }
    },

    calculateWeight: function($el) {
      var sum = 0,
          $quantityInputs = $el.find('.hhg-quantity-input'),
          $weightInputs = $el.find('.hhg-weight-input');

      $quantityInputs.each(function() {
        var val = parseInt($(this).val());

        if (val > 0) {
          sum += val * $('#' + this.id + '_weight').val();
        }
      });

      $weightInputs.each(function() {
        var val = parseInt($(this).val());

        if (val > 0) {
          sum += val;
        }
      });

      return sum;
    },

    setup: function() {
      this.$categoryButtons.on('click', this.events.clickCategoryButton.bind(this));
      this.$estimateButton.on('click', this.events.clickEstimateButton.bind(this));
    }
  };

  var $container = $('#weight-estimator');

  if ($container.length) {
    new WeightEstimator({
      $categoryButtons: $container.find('.category-calculate-button'),
      $estimateButton: $('#calculate-button'),
      $container: $container,
      $weightResult: $('#weight-result')
    });
  }
})(window, jQuery);
