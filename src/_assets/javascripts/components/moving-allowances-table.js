(function(window, $) {
  var $window = $(window);

  var MovingAllowancesTable = window.MovingAllowancesTable = function($el) {
    this.$el = $el;

    $window.on('update', this.events.update.bind(this));

    this.$el.find('.view-details').each(function() {
      var $clone = $(this.hash).clone();

      $clone.find('h4, .return-to-moving-allowances').remove();
      $clone.removeAttr('id').insertAfter($(this));
    });

    this.$el.addClass('moving-allowances-table-enhanced');

    this.toggle(true);
  };

  MovingAllowancesTable.prototype = {
    events: {
      update: function(event, data) {
        this.toggle(data.payGrade !== this.$el.data('payGrade'));

        this.$el.attr({
          'data-dependency-status': data.dependencyStatus,
          'data-move-type': data.moveType
        });
      }
    },

    toggle: function(hidden) {
      this.$el[hidden ? 'attr' : 'removeAttr']('hidden', true);
    }
  };
})(window, jQuery);
