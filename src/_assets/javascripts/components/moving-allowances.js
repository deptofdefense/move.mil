(function(window, $) {
  var hideElement = function($el) {
    return $el.attr('hidden', true);
  };

  var showElement = function($el) {
    return $el.removeAttr('hidden');
  };

  var MovingAllowances = window.MovingAllowances = function() {
    this.$form = $('#moving-allowances-form');

    if (this.$form) {
      this.$payGradeInput = $('#pay-grade');
      this.$container = $('#moving-allowances');
      this.$tables = this.$container.find('.moving-allowances-table');

      this.$form.on('submit', this.events.submit.bind(this));

      showElement(this.$form);

      hideElement(this.$container).attr('tabindex', -1);
    }
  };

  MovingAllowances.prototype = {
    events: {
      submit: function(event) {
        event.preventDefault();

        var payGradeInputValue = this.$payGradeInput.val();

        if (payGradeInputValue.length) {
          showElement(this.$container);

          this.$tables.each(function(index, element) {
            var $table = $(element);

            if ($table.data('payGrade') === payGradeInputValue) {
              showElement($table);

              this.$container.trigger('focus');
            } else {
              hideElement($table);
            }
          }.bind(this));
        } else {
          hideElement(this.$container);
        }
      }
    }
  };
})(window, jQuery);
