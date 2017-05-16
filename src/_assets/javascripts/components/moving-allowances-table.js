(function(window, $) {
  var $window = $(window);

  var MovingAllowancesTable = window.MovingAllowancesTable = function($el) {
    this.$el = $el;

    $window.on('update', this.events.update.bind(this));

    this.toggle(true);
  };

  MovingAllowancesTable.prototype = {
    events: {
      update: function(event, data) {
        this.toggle(data.payGrade !== this.$el.data('payGrade'));
      }
    },

    toggle: function(hidden) {
      this.$el[hidden ? 'attr' : 'removeAttr']('hidden', true);
    }
  };
})(window, jQuery);
