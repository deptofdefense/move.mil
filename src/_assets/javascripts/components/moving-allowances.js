(function(window, $) {
  var $window = $(window);

  var MovingAllowances = window.MovingAllowances = function($el) {
    this.$el = $el;

    new MovingAllowancesForm($('#moving-allowances-form'));

    new MovingAllowancesAlert(this.$el.find('.usa-alert-info'));

    this.$el.find('.moving-allowances-table').each(function() {
      new MovingAllowancesTable($(this));
    });

    $window.on('update', this.events.update.bind(this));

    this.$el.addClass('moving-allowances-section-enhanced');
  };

  MovingAllowances.prototype = {
    events: {
      update: function(event, data) {
        if (data.payGrade || data.dependencyStatus || data.moveType) {
          this.$el.trigger('focus');
        }
      }
    }
  };
})(window, jQuery);
