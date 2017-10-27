(function(window, $) {
  'use strict';

  $(window).on('hashchange', function() {
    var hash = window.location.hash;
    var $element = $(hash);

    if ($element.length && $element.hasClass('linkable-accordion-item')) {
      var $accordion = $element.closest('.linkable-accordion');
      var $accordionItems = $accordion.find('.linkable-accordion-item');

      $accordionItems.each(function() {
        var $item = $(this);
        var shouldExpand = ('#' + $item.attr('id') == hash);

        $item.find('.usa-accordion-button').attr('aria-expanded', shouldExpand);
        $item.find('.usa-accordion-content').attr('aria-hidden', !shouldExpand);
      });

    }
  }).trigger('hashchange');
})(window, jQuery);
