/*
    We used the thorough analysis and scripting of Jason Kiss for these ARIA tabs.
    See Accessible ARIA Tabs: http://www.accessibleculture.org/articles/2010/08/aria-tabs/
    for his analysis, examples and conclusions. Thanks, Jason!
*/
(function(window, $) {
  'use strict';
  var $tabs = $('#tabs');

  // For each individual tab DIV, set class and aria role attributes, and hide it
  $tabs.find('> div').attr({
    role: 'tabpanel',
    'aria-hidden': true
  }).addClass('tabPanel').hide();

  // Get the list of tab links
  var $tabsList = $tabs.find('ul:first').attr({
    class: 'tabsList',
    role: 'tablist'
  });

  // For each item in the tabs list...
  $tabsList.find('li > a').each(function(idx) {
    var $anchor = $(this);

    // Create a unique id using the link's href
    var tabId = 'tab-' + $anchor.attr('href').slice(1);

    // Assign tab id, aria and tabindex attributes to the tab control, but do not remove the href
    $anchor.attr({
      id: tabId,
      role: 'tab',
      'aria-selected': false,
      tabindex: -1
    }).parent().attr('role', 'presentation');

    // Assign aria attribute to the relevant tab panel
    $tabs.find('.tabPanel').eq(idx).attr('aria-labelledby', tabId);

    // Set the click event for each tab link
    $anchor.on('click', function(e) {
      // Prevent default click event
      e.preventDefault();

      // Change state of previously selected tabList item
      $tabsList.find('> li.current').removeClass('current').find('> a').attr({
        'aria-selected': false,
        tabindex: -1
      });

      // Hide previously selected tabPanel
      $tabs.find('.tabPanel:visible').attr('aria-hidden', 'true').hide();

      // Show newly selected tabPanel
      $tabs.find('.tabPanel').eq($anchor.parent().index()).attr('aria-hidden', 'false').show();

      // Set state of newly selected tab list item
      $anchor.attr({
        'aria-selected': true,
        tabindex: 0
      }).parent().addClass('current');

      $anchor.trigger('focus');
    });
  });

  // Set keydown events on tabList item for navigating tabs
  $tabsList.on('keydown', 'a', function(event) {
    // cache references to elements we'll be using in this event handler
    var $clickedTab = $(this).parent(),
        $nextTab = $clickedTab.next(),
        $prevTab = $clickedTab.prev(),
        $newActiveTab;

    if (event.which === 37 || event.which === 38) {
      // cache a reference to the tab that will be highlighted as a result of this user action
      // use a ternary operator to assign $newActiveTab by evaluating $prevTab's length which might be zero (falsey)
      $newActiveTab = $prevTab.length ? $prevTab.find('a') : $tabsList.find('li:last a');
    } else if (event.which === 39 || event.which === 40) {
      $newActiveTab = $nextTab.length ? $nextTab.find('a') : $tabsList.find('li:first a');
    }

    if ($newActiveTab && $newActiveTab.length) {
      // `.trigger('click')` is more direct than `.click()` (which internally calls `.trigger('click')`…)
      $newActiveTab.trigger('click');
      // prevent native browser behavior (in particular, scrolling up and down)
      return false;
    }
  });

  var $anchor_current;
  var stripped_url = document.location.toString().split("#");
  if (stripped_url.length > 1) {
    // Does an anchor with the correct id exist with this anchor value?
    $anchor_current = $('[id="tab-' + stripped_url[1] + '"]:first');
  }

  if ($anchor_current && $anchor_current.length == 1) {
    // Show the tabPanel specified by the anchor
    $anchor_current.trigger('click');
  } else {
    // Show the first tabPanel
    $tabs.find('.tabPanel:first').attr('aria-hidden', 'false').show();

    // Set state for the first tabsList li
    $tabsList.find('li:first').addClass('current').find(' > a').attr({
      'aria-selected': true,
      tabindex: 0
    });
  }
})(window, jQuery);
