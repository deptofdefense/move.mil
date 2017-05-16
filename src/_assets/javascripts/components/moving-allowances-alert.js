(function(window, $) {
  var $window = $(window);

  var MovingAllowancesAlert = window.MovingAllowancesAlert = function($el) {
    this.$el = $el;

    $window.on('update', this.events.update.bind(this));

    this.toggle(false);
  };

  MovingAllowancesAlert.prototype = {
    events: {
      update: function(event, data) {
        if (data.payGrade || data.dependencyStatus || data.moveType) {
          this.$el.toggle(false);
        } else {
          this.$el.toggle(true);
        }
      }
    },

    toggle: function(hidden) {
      this.$el[hidden ? 'attr' : 'removeAttr']('hidden', true);
    }
  };
})(window, jQuery);
