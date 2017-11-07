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
  var $ppmEntitlementWeight = $('#ppm-entitlement-weight');
  var $ppmEntitlementProgear = $('#ppm-entitlement-progear');
  var $ppmEntitlementProgearSpouse = $('#ppm-entitlement-progear-spouse');
  $ppmEntitlementWeight.css('visibility', 'hidden');
  $ppmEntitlementProgear.css('visibility', 'hidden');
  $ppmEntitlementProgearSpouse.css('visibility', 'hidden');
  var entitlementsJson = $('#entitlements-json').data('entitlementsJson');

  var onPersonalInfoChanged = function () {
    if (!$rank.val() || $('input[name="dependents"]:checked').length == 0) {
      $ppmEntitlementWeight.css('visibility', 'hidden');
      $ppmEntitlementProgear.css('visibility', 'hidden');
      $ppmEntitlementProgearSpouse.css('visibility', 'hidden');
    }
    else {
      var entitlement = entitlementsJson.find(function(data) { return data.slug == $rank.val(); });

      var totalWeightSelf = $('#dependents_yes').checked ?
          (entitlement.total_weight_self_plus_dependents > 0 ? entitlement.total_weight_self_plus_dependents : 0) :
          (entitlement.total_weight_self > 0 ? entitlement.total_weight_self : 0);
      $('#entitlement_weight').text(totalWeightSelf.toString());
      $ppmEntitlementWeight.css('visibility', 'visible');

      var proGearWeight = entitlement.pro_gear_weight > 0 ? entitlement.pro_gear_weight : 0;
      $('#entitlement_progear').text(proGearWeight.toString());
      $ppmEntitlementProgear.css('visibility', 'visible');

      // The visibility of the spouse progear field is controlled elsewhere, so it is safe to make this label visible regardless
      var proGearWeightSpouse = entitlement.pro_gear_weight_spouse > 0 ? entitlement.pro_gear_weight_spouse : 0;
      $('#entitlement_progear_spouse').text(proGearWeightSpouse.toString());
      $ppmEntitlementProgearSpouse.css('visibility', 'visible');
    }
  };

  $rank.on('change', onPersonalInfoChanged);
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
