//= require 'jquery/jquery'
//= require 'owl.carousel/owl.carousel'
//= require 'uswds/uswds'
//= require_tree ./components

(function(window, $) {
  var $movingAllowancesContainer = $('#moving-allowances');

  if ($movingAllowancesContainer) {
    new MovingAllowances($movingAllowancesContainer);
  }

  $('.owl-carousel').owlCarousel({
    loop: true,
    margin: 10,
    nav: true,
    responsive: {
      0: {
        items: 1
      }
    }
  });
})(window, jQuery);
