(function(window, $) {
  var MovingAllowances = window.MovingAllowances = function($el) {
    this.$el = $el;

    new MovingAllowancesForm($('#moving-allowances-form'));

    new MovingAllowancesAlert(this.$el.find('.usa-alert-info'));

    this.$el.find('.moving-allowances-table').each(function() {
      new MovingAllowancesTable($(this));
    });
  };
})(window, jQuery);
