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
  var $weightAllowanceText = $('#weight-allowance-text');
  var $progearAllowanceText = $('#progear-allowance-text');
  var $progearSpouseAllowanceText = $('#progear-spouse-allowance-text');
  $weightAllowanceText.css('visibility', 'hidden');
  $progearAllowanceText.css('visibility', 'hidden');
  $progearSpouseAllowanceText.css('visibility', 'hidden');
  var entitlementsJson = $('#entitlements-json').data('entitlementsJson');

  var getEntitlementWeightSelf = function(entitlement) {
    return $('#dependents_yes').checked ?
      (entitlement.total_weight_self_plus_dependents > 0 ? entitlement.total_weight_self_plus_dependents : 0) :
      (entitlement.total_weight_self > 0 ? entitlement.total_weight_self : 0);
  };

  var getEntitlementProgear = function(entitlement) {
    return entitlement.pro_gear_weight > 0 ? entitlement.pro_gear_weight : 0;
  };

  var getEntitlementProgearSpouse = function(entitlement) {
    return entitlement.pro_gear_weight_spouse > 0 ? entitlement.pro_gear_weight_spouse : 0;
  };

  var onPersonalInfoChanged = function () {
    if (!$rank.val() || $('input[name="dependents"]:checked').length == 0) {
      $weightAllowanceText.css('visibility', 'hidden');
      $progearAllowanceText.css('visibility', 'hidden');
      $progearSpouseAllowanceText.css('visibility', 'hidden');
    }
    else {
      var entitlement = entitlementsJson.find(function(data) { return data.slug == $rank.val(); });

      var totalWeightSelf = getEntitlementWeightSelf(entitlement);
      $('#entitlement_weight').text(totalWeightSelf.toString());
      $weightAllowanceText.css('visibility', 'visible');
      onWeightInput(null);

      var proGearWeight = getEntitlementProgear(entitlement);
      $('#entitlement_progear').text(proGearWeight.toString());
      $progearAllowanceText.css('visibility', 'visible');
      onWeightProgearInput(null);

      // The visibility of the spouse progear field is controlled elsewhere, so it is safe to make this label visible regardless
      var proGearWeightSpouse = getEntitlementProgearSpouse(entitlement);
      $('#entitlement_progear_spouse').text(proGearWeightSpouse.toString());
      $progearSpouseAllowanceText.css('visibility', 'visible');
      onWeightProgearSpouseInput(null);
    }
  };

  var validateEntitlementField = function($input, getEntitlementFn) {
    // an empty field is never an error
    if ($input.val() == '')
      return true;

    // Some kinds of input validation can happen whether or not we know what the entitlement is
    var weightLbs = parseInt($input.val());
    if (weightLbs == NaN || weightLbs < 0)
      return false;

    // If the rank has not been chosen yet, then the entitlement cannot be loaded. Whatever the number is, it's fine for now
    if (!$rank.val())
      return true;

    var entitlement = entitlementsJson.find(function(data) { return data.slug == $rank.val(); });
    var entitlementWeight = getEntitlementFn(entitlement);
    return weightLbs <= entitlementWeight;
  };

  var onWeightInput = function(e) {
    if (validateEntitlementField($('#weight'), getEntitlementWeightSelf))
      $('#weight-section').removeClass('usa-input-error');
    else
      $('#weight-section').addClass('usa-input-error');
  };

  var onWeightProgearInput = function(e) {
    if (validateEntitlementField($('#weight_progear'), getEntitlementProgear))
      $('#progear-section').removeClass('usa-input-error');
    else
      $('#progear-section').addClass('usa-input-error');
  };

  var onWeightProgearSpouseInput = function(e) {
    if (validateEntitlementField($('#weight_progear_spouse'), getEntitlementProgearSpouse))
      $('#progear-spouse-section').removeClass('usa-input-error');
    else
      $('#progear-spouse-section').addClass('usa-input-error');
  };

  $rank.on('change', onPersonalInfoChanged);
  $('#dependents_yes').change(onPersonalInfoChanged);
  $('#dependents_no').change(onPersonalInfoChanged);
  $('#married_yes').change(function() { $('#progear-spouse-section').removeAttr('hidden'); });
  $('#married_no').change(function() { $('#progear-spouse-section').attr('hidden', true); });

  $('#weight').on('input', onWeightInput);
  $('#weight_progear').on('input', onWeightProgearInput);
  $('#weight_progear_spouse').on('input', onWeightProgearSpouseInput);
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
