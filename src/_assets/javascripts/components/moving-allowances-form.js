(function(window, $) {
  var $window = $(window);

  var MovingAllowancesForm = window.MovingAllowancesForm = function($el) {
    this.$el = $el;

    this.$dependencyStatusInput = $('#dependency-status');
    this.$moveTypeInput = $('#move-type');
    this.$payGradeInput = $('#pay-grade');

    this.$el.on('submit', this.events.submit.bind(this));

    this.toggle(false);
  };

  MovingAllowancesForm.prototype = {
    events: {
      submit: function(event) {
        event.preventDefault();

        $window.trigger('update', {
          dependencyStatus: this.$dependencyStatusInput.val(),
          moveType: this.$moveTypeInput.val(),
          payGrade: this.$payGradeInput.val()
        });
      }
    },

    toggle: function(hidden) {
      this.$el[hidden ? 'attr' : 'removeAttr']('hidden', true);
    }
  };
})(window, jQuery);
