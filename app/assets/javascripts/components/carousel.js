(function(window, $) {
  'use strict';

  $('.owl-carousel').owlCarousel({
    loop: true,
    margin: 10,
    nav: true,
    responsive: {
      0: {
        items: 1
      }
    },
    autoHeight: true
  });
})(window, jQuery);
