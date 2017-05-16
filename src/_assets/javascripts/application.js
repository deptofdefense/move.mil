//= require 'jquery/jquery'
//= require 'uswds/uswds'
//= require_tree ./components

(function(window, $) {
  var $movingAllowancesContainer = $('#moving-allowances');

  if ($movingAllowancesContainer) {
    new MovingAllowances($movingAllowancesContainer);
  }
})(window, jQuery);
