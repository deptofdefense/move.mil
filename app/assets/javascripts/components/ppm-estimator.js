(function(window, $) {
  'use strict';

  var $ppmEstimateForm = $('#ppm-estimate-form');
  if ($ppmEstimateForm.length == 0)
    return;

  var PpmEstimator = function(options) {
    this.$alert = options.$alert;
    this.$form = options.$form;
    this.$results = options.$results;

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
    },

    handleAjaxSuccess: function(markup) {
      this.$alert.attr('hidden', true);
      this.$form.attr('hidden', true);
      this.$results.html(markup).removeAttr('hidden');
    }
  };

  new PpmEstimator({
    $alert: $('#ppm-estimate-alert'),
    $form: $ppmEstimateForm,
    $results: $('#ppm-estimate-results')
  });

  var $rank = $('#rank');
  var $branch = $('#branch');
  var $ppmEntitlementWeight = $('#ppm-entitlement-weight');
  var $ppmEntitlementProgear = $('#ppm-entitlement-progear');
  var $ppmEntitlementProgearSpouse = $('#ppm-entitlement-progear-spouse');
  $ppmEntitlementWeight.css('visibility', 'hidden');
  $ppmEntitlementProgear.css('visibility', 'hidden');
  $ppmEntitlementProgearSpouse.css('visibility', 'hidden');

  var onPersonalInfoChanged = function () {
    if (!$rank.val() || !$branch.val() || $('input[name="dependents"]:checked').length == 0) {
      $ppmEntitlementWeight.css('visibility', 'hidden');
      $ppmEntitlementProgear.css('visibility', 'hidden');
      $ppmEntitlementProgearSpouse.css('visibility', 'hidden');
    }
    else {
      $ppmEntitlementWeight.css('visibility', 'visible');
      $ppmEntitlementProgear.css('visibility', 'visible');
      $ppmEntitlementProgearSpouse.css('visibility', 'visible');
    }
  };

  $rank.on('change', onPersonalInfoChanged);
  $branch.on('change', onPersonalInfoChanged);
  $('#dependents_yes').on('change', onPersonalInfoChanged);
  $('#dependents_no').on('change', onPersonalInfoChanged);
  $('#married_yes').on('change', function() { $('#ppm-progear-spouse').removeAttr('hidden'); });
  $('#married_no').on('change', function() { $('#ppm-progear-spouse').attr('hidden', true); });

})(window, jQuery);

function isDigitKey(evt) {
  var charCode = (evt.which) ? evt.which : event.keyCode
  return (charCode >= 48 && charCode <= 57);
}

function onZipCodeKey(field, evt) {
  return isDigitKey(evt) && field.value.length < 5;
}

function onEditDetails() {
  $('#ppm-estimate-form').removeAttr('hidden');
  $('#ppm-estimate-results').attr('hidden', true);
}
