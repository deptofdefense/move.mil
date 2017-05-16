(function(window, $) {
  var toggleElement = function($el, showElement) {
    return $el[showElement ? 'removeAttr' : 'attr']('hidden', true);
  };

  var MovingAllowances = window.MovingAllowances = function() {
    this.$form = $('#moving-allowances-form');

    if (this.$form) {
      this.$payGradeInput = $('#pay-grade');
      this.$container = $('#moving-allowances');
      this.$alert = this.$container.find('.usa-alert-info');
      this.$tables = this.$container.find('.moving-allowances-table');

      this.$form.on('submit', this.events.submit.bind(this));

      toggleElement(this.$form, true);
      toggleElement(this.$alert, true);

      this.hideTables();
    }
  };

  MovingAllowances.prototype = {
    events: {
      submit: function(event) {
        event.preventDefault();

        var payGradeInputValue = this.$payGradeInput.val();

        this.hideTables();

        if (payGradeInputValue.length) {
          var $table = this.$tables.filter(function() {
            return $(this).data('payGrade') === payGradeInputValue;
          });

          toggleElement(this.$alert, false);
          toggleElement($table, true);

          this.$container.trigger('focus');
        } else {
          toggleElement(this.$alert, true);
        }
      }
    },

    hideTables: function() {
      this.$tables.each(function() {
        toggleElement($(this), false);
      });
    }
  };
})(window, jQuery);
