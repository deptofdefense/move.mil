(function(window, $) {
  'use strict';

})(window, jQuery);

function isDigitKey(evt) {
  var charCode = (evt.which) ? evt.which : event.keyCode
  return (charCode >= 48 && charCode <= 57);
}

function onZipCodeKey(field, evt) {
  return isDigitKey(evt) && field.value.length < 5;
}
