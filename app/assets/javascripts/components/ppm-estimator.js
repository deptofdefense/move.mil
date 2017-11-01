(function(window, $) {
  'use strict';

  var PpmEstimator = function(options) {
    this.$alert = options.$alert;
    this.$form = options.$form;
    this.$results = options.$results;
    this.$resultsContainer = options.$resultsContainer;

    this.$form.on('submit', this.events.submit.bind(this));
  };

  PpmEstimator.prototype = {
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
      this.$form.removeAttr('hidden');
      this.$resultsContainer.trigger('focus');
    },

    handleAjaxSuccess: function(markup) {
      this.$alert.attr('hidden', true);
      this.$form.attr('hidden', true);
      this.$results.html(markup).removeAttr('hidden');
      this.$resultsContainer.trigger('focus');
    }
  };

  var $ppmEstimateForm = $('#ppm-estimate-form');

  if ($ppmEstimateForm.length) {
    new PpmEstimator({
      $alert: $('#ppm-estimate-alert'),
      $form: $ppmEstimateForm,
      $results: $('#ppm-estimate-results'),
      $resultsContainer: $('#ppm-estimate-results-container')
    });
  }

})(window, jQuery);

function isDigitKey(evt) {
  var charCode = (evt.which) ? evt.which : event.keyCode
  return (charCode >= 48 && charCode <= 57);
}

function onZipCodeKey(field, evt) {
  return isDigitKey(evt) && field.value.length < 5;
}
