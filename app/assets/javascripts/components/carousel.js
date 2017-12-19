(function(window, $) {
  'use strict';

  $('.owl-carousel').owlCarousel({
    loop: false,
    nav: true,
    navText: ['Prev', 'Next'],
    responsive: {
      0: {
        items: 1
      }
    },
    dots: false
  });
})(window, jQuery);
