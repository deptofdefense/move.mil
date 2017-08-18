(function(window, $) {
  'use strict';

  var EntitlementSearch = function(options) {
    this.$alert = options.$alert;
    this.$form = options.$form;
    this.$results = options.$results;
    this.$resultsContainer = options.$resultsContainer;

    this.$form.on('submit', this.events.submit.bind(this));
  };

  EntitlementSearch.prototype = {
    events: {
      submit: function(event) {
        event.preventDefault();

        $.ajax({
          data: this.$form.serialize(),
          error: this.handleAjaxError.bind(this),
          method: this.$form.attr('method'),
          success: this.handleAjaxSuccess.bind(this),
          url: this.$form.attr('action')
        });
      }
    },

    handleAjaxError: function() {
      this.$results.empty().attr('hidden', true);
      this.$alert.removeAttr('hidden');
      this.$resultsContainer.trigger('focus');
    },

    handleAjaxSuccess: function(markup) {
      this.$alert.attr('hidden', true);
      this.$results.html(markup).removeAttr('hidden');
      this.$resultsContainer.trigger('focus');
    }
  };

  var $container = $('#entitlements-search');

  if ($container.length) {
    new EntitlementSearch({
      $alert: $('#entitlements-search-alert'),
      $form: $container.find('form'),
      $results: $('#entitlements-search-results'),
      $resultsContainer: $('#entitlements-search-results-container')
    });

    $container.removeAttr('hidden');

    $('#entitlements-rank-list').attr('hidden', true);
  }
})(window, jQuery);
