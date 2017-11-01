(function(window, $) {
  'use strict';

  var CoordinatesSearchForm = function(options) {
    this.$outerContainer = options.$outerContainer;
    this.$buttons = options.$buttons;
    this.$weightResult = options.$weightResult;

    this.setup();
  };

  CoordinatesSearchForm.prototype = {
    calculateWeight: function($container) {
      var sum = 0;

      var $quantityInputs = $container.find('.hhg-quantity-input');
      $quantityInputs.each(function() {
        var $input = $(this);
        if ($input.val() > 0) {
          var $weightInput = $('#' + this.id + '_weight');
          sum += $input.val() * $weightInput.val();
        }
      });

      var $weightInputs = $container.find('.hhg-weight-input');
      $weightInputs.each(function() {
        var $input = $(this);
        if ($input.val() > 0) {
          sum += parseInt($input.val());
        }
      });

      return sum;
    },

    events: {
      click: function(event) {
        event.preventDefault();

        var $button = $(event.target);
        var total = this.calculateWeight(this.$outerContainer);

        var isSubtotalButton = $button.hasClass('category-calculate-button');
        if (isSubtotalButton) {
          var $categoryContainer = $button.closest('.hhg-category');
          var subtotal = this.calculateWeight($categoryContainer);

          var categoryKey = $button.attr('id');
          var $subtotalInput = $categoryContainer.find('#' + categoryKey + '_subtotal');
          var $totalInput = $categoryContainer.find('#' + categoryKey + '_total');

          $subtotalInput.val(subtotal);
          $totalInput.val(total);
        } else {
          var packing_days = '4 days';
          if (total < 5000) {
            packing_days = '1 day';
          } else if (total < 7000) {
            packing_days = '2 days';
          } else if (total < 9000) {
            packing_days = '3 days';
          }
          this.$weightResult.html(
            '<div>Estimated grand total: ' + total + ' lbs</div>' +
            '<div>Average time to pack ' + total + ' lbs is ' + packing_days + '</div>'
          );
        }
      }
    },

    setup: function() {
      for (var i = 0; i < this.$buttons.length; i++) {
        $(this.$buttons[i]).on('click', this.events.click.bind(this));
      }
    }
  };

  var $outerContainer = $('#weight-estimator');

  if ($outerContainer.length) {
    new CoordinatesSearchForm({
      $outerContainer: $outerContainer,
      $buttons: $outerContainer.find('button'),
      $weightResult: $('#weight-result')
    });
  }
})(window, jQuery);
