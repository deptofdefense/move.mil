//= require 'uswds/uswds'
//= require 'jquery'
//= require 'owl-carousel2'

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
    }
  });
})(window, jQuery);
