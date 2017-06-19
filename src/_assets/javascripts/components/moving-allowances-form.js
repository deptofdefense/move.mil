(function(window, $) {
  var $window = $(window);

  var getParamsFromQueryString = function(queryString) {
    var params = [];

    queryString.substr(1).split('&').forEach(function(item) {
      var parts = item.split('=');

      params[parts[0]] = decodeURIComponent(parts[1]);
    });

    return params;
  };

  var MovingAllowancesForm = window.MovingAllowancesForm = function($el) {
    this.$el = $el;

    this.$dependencyStatusInput = $('#dependency-status');
    this.$moveTypeInput = $('#move-type');
    this.$payGradeInput = $('#pay-grade');

    var params = getParamsFromQueryString(location.search);

    if (params.moveType && this.$moveTypeInput.find('option[value="' + params.moveType + '"]').length) {
      this.$moveTypeInput.val(params.moveType);
    }

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
