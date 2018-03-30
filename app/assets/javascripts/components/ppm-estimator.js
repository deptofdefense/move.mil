(function(window, $) {
  'use strict';

  var $ppmEstimateForm = $('#ppm-estimate-form');
  if ($ppmEstimateForm.length == 0)
    return;

  var PpmEstimatorMapMarker = function(options) {
    this.$container = options.$container;
    this.id = options.id;
    this.name = options.name;
    this.latitude = options.latitude;
    this.longitude = options.longitude;
    this.icon = options.icon;

    this.setup();
  };

  PpmEstimatorMapMarker.prototype = {
    setup: function() {
      this.marker = L.marker([this.latitude, this.longitude], {
        alt: 'Map marker for ' + this.name,
        icon: this.icon,
        riseOnHover: true,
        title: this.name
      });
    }
  };

  var PpmEstimatorMap = function(options) {
    this.$container = options.$container;
    this.startCoords = this.$container.data('startLatlon');
    this.endCoords = this.$container.data('endLatlon');

    this.map = L.map(this.$container.attr('id'), {
      maxZoom: 18,
      scrollWheelZoom: false,
      zoomAnimation: false,
      zoomControl: false
    });

    this.setup();
    this.fitBounds();
    this.map.on('resize', function(evt) { this.fitBounds(); }.bind(this));
  };

  PpmEstimatorMap.prototype = {
    setup: function() {
      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: 'Map data © <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors. Map imagery © <a href="https://www.mapbox.com">Mapbox</a>.'
      }).addTo(this.map);

      var $iconDefaults = $.extend({}, L.Icon.Default.prototype.options, {
        iconUrl: this.$container.data('iconUrl'),
        iconRetinaUrl: this.$container.data('iconRetinaUrl'),
        shadowUrl: this.$container.data('shadowUrl'),
      });

      L.marker(this.startCoords, { icon: L.icon($iconDefaults) }).addTo(this.map);
      L.marker(this.endCoords, { icon: L.icon($iconDefaults) }).addTo(this.map);

      var polyline = L.polyline([this.startCoords, this.endCoords], {color: 'blue'}).addTo(this.map);
    },

    fitBounds: function() {
      this.map.fitBounds([this.startCoords, this.endCoords], {
        animate: false,
        padding: [32, 32]
      });
    }
  };

  var PpmEstimator = function(options) {
    this.$alert = options.$alert;
    this.$form = options.$form;
    this.$results = options.$results;

    this.$rank = $('#rank');
    this.$weightAllowanceText = $('#weight-allowance-text');
    this.$progearAllowanceText = $('#progear-allowance-text');
    this.$progearSpouseAllowanceText = $('#progear-spouse-allowance-text');
    this.$weightAllowanceText.css('visibility', 'hidden');
    this.$progearAllowanceText.css('visibility', 'hidden');
    this.$progearSpouseAllowanceText.css('visibility', 'hidden');
    this.entitlementsJson = $('#entitlements-json').data('entitlementsJson');

    this.setup();
  };

  PpmEstimator.prototype = {
    events: {
      submit: function(event) {
        event.preventDefault();

        if (!this.validateDate())
          return;

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
      $('#ppm-estimate-alert')[0].scrollIntoView(false);
    },

    handleAjaxSuccess: function(markup) {
      this.$alert.attr('hidden', true);
      this.$results.html(markup).removeAttr('hidden');

      var $container = $('#ppm-estimator-map');

      if ($container.length) {
        new PpmEstimatorMap({
          $container: $container
        });
      }

      $('#ppm-footer')[0].scrollIntoView(false);
    },

    getEntitlementWeightSelf: function(entitlement) {
      return $('#dependents_yes').prop('checked') ? entitlement.total_weight_self_plus_dependents : entitlement.total_weight_self;
    },

    getEntitlementProgear: function(entitlement) {
      return entitlement.pro_gear_weight > 0 ? entitlement.pro_gear_weight : 0;
    },

    getEntitlementProgearSpouse: function(entitlement) {
      return entitlement.pro_gear_weight_spouse > 0 ? entitlement.pro_gear_weight_spouse : 0;
    },

    onPersonalInfoChanged: function() {
      if (!this.$rank.val() || $('input[name="dependents"]:checked').length == 0) {
        this.$weightAllowanceText.css('visibility', 'hidden');
        this.$progearAllowanceText.css('visibility', 'hidden');
        this.$progearSpouseAllowanceText.css('visibility', 'hidden');
      }
      else {
        var entitlement = this.entitlementsJson[this.$rank.val()];

        var totalWeightSelf = this.getEntitlementWeightSelf(entitlement);
        $('#entitlement_weight').text(totalWeightSelf.toString());
        this.$weightAllowanceText.css('visibility', 'visible');
        this.onWeightInput(null);

        var proGearWeight = this.getEntitlementProgear(entitlement);
        $('#entitlement_progear').text(proGearWeight.toString());
        this.$progearAllowanceText.css('visibility', 'visible');
        this.onWeightProgearInput(null);

        var proGearWeightSpouse = this.getEntitlementProgearSpouse(entitlement);
        $('#entitlement_progear_spouse').text(proGearWeightSpouse.toString());
        this.$progearSpouseAllowanceText.css('visibility', 'visible');
        this.onWeightProgearSpouseInput(null);
      }

      if ($('#dependents_yes')[0].checked)
        $('#progear-spouse-section').removeAttr('hidden');
      else
        $('#progear-spouse-section').attr('hidden', true);
    },

    isLeapYear: function(year) {
      return (year % 4 == 0) && ((year % 400 == 0) || (year % 100 != 0));
    },

    isValidDate: function(year, month, day) {
      if (month < 1 || month > 12)
        return false;
      var daysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
      var maxDay = daysPerMonth[month - 1];
      if (month == 2 && this.isLeapYear(year))
         maxDay = 29;
      return (day >= 1 && day <= maxDay);
    },

    validateDate: function() {
      var year = $('#date_year').val();
      var month = $('#date_month').val();
      var day = $('#date_day').val();
      if (this.isValidDate(year, month, day)) {
        $('#date-section').removeClass('usa-input-error');
        return true;
      } else {
        $('#date-section').addClass('usa-input-error');
        $('#date-section')[0].scrollIntoView();
        return false;
      }
    },

    validateEntitlementField: function($input, getEntitlementFn) {
      // an empty field is never an error
      if ($input.val() == '')
        return true;

      // Some kinds of input validation can happen whether or not we know what the entitlement is
      var weightLbs = parseInt($input.val());
      if (weightLbs == NaN || weightLbs < 0)
        return false;

      // If the rank has not been chosen yet, then the entitlement cannot be loaded. Whatever the number is, it's fine for now
      if (!this.$rank.val())
        return true;

      var entitlement = this.entitlementsJson[this.$rank.val()];
      var entitlementWeight = getEntitlementFn(entitlement);
      return weightLbs <= entitlementWeight;
    },

    onWeightInput: function(e) {
      if (this.validateEntitlementField($('#weight'), this.getEntitlementWeightSelf))
        $('#weight-section').removeClass('usa-input-error');
      else
        $('#weight-section').addClass('usa-input-error');
    },

    onWeightProgearInput: function(e) {
      if (this.validateEntitlementField($('#weight_progear'), this.getEntitlementProgear))
        $('#progear-section').removeClass('usa-input-error');
      else
        $('#progear-section').addClass('usa-input-error');
    },

    onWeightProgearSpouseInput: function(e) {
      if (this.validateEntitlementField($('#weight_progear_spouse'), this.getEntitlementProgearSpouse))
        $('#progear-spouse-section').removeClass('usa-input-error');
      else
        $('#progear-spouse-section').addClass('usa-input-error');
    },

    setup: function() {
      this.$form.on('submit', this.events.submit.bind(this));

      this.$rank.on('change', this.onPersonalInfoChanged.bind(this));
      $('#dependents_yes').change(this.onPersonalInfoChanged.bind(this));
      $('#dependents_no').change(this.onPersonalInfoChanged.bind(this));

      $('#weight').on('input', this.onWeightInput.bind(this));
      $('#weight_progear').on('input', this.onWeightProgearInput.bind(this));
      $('#weight_progear_spouse').on('input', this.onWeightProgearSpouseInput.bind(this));
    }
  };

  new PpmEstimator({
    $alert: $('#ppm-estimate-alert'),
    $form: $ppmEstimateForm,
    $results: $('#ppm-estimate-results')
  });

})(window, jQuery);
