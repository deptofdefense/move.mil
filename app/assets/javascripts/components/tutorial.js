(function(window, $) {
  'use strict';

  var $container = $('#tutorial');

  if ($container.length) {
    var $showAllButton = $('#show-all');
    $showAllButton.on('click', function() {
      event.preventDefault();
      $container.toggleClass('single-page-tutorial');
    });
  }
})(window, jQuery);
