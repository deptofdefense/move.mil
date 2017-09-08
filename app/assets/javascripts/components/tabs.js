(function(window, $) {
  'use strict';

  var AriaTabs = window.AriaTabs = function(options) {
    this.$container = options.$container;
    this.$list = options.$list;
    this.$controls = this.$list.find('a');
    this.$panels = options.$panels;

    var $activeControl = $('#tab-' + location.hash.split('#')[1]);

    this.setup();
    this.deactivate();
    this.activate($activeControl.length ? $activeControl : this.$controls.first());
  };

  AriaTabs.prototype = {
    events: {
      click: function(event) {
        event.preventDefault();
      },

      focus: function(event) {
        this.deactivate();
        this.activate($(event.currentTarget));
      },

      keydown: function(event) {
        if (event.which !== 37 && event.which !== 39) {
          return true;
        }

        event.preventDefault();

        var $activeControl = $(event.currentTarget),
            $activeControlParent = $activeControl.parent(),
            $newActiveControl;

        if (event.which === 37) {
          var $prev = $activeControlParent.prev();

          $newActiveControl = $prev.length ? $prev.find('a') : this.$controls.last();
        } else if (event.which === 39) {
          var $next = $activeControlParent.next();

          $newActiveControl = $next.length ? $next.find('a') : this.$controls.first();
        }

        $newActiveControl.trigger('focus');
      }
    },

    activate: function($control) {
      $control.attr({
        'aria-selected': true,
        tabindex: 0
      });

      $('#' + $control.attr('aria-controls')).removeAttr('aria-hidden').removeAttr('hidden');
    },

    deactivate: function() {
      this.$controls.attr({
        'aria-selected': false,
        tabindex: -1
      });

      this.$panels.attr({
        'aria-hidden': true,
        hidden: true
      });
    },

    setup: function() {
      this.$list.attr('role', 'tablist');
      this.$list.find('li').attr('role', 'presentation');

      this.$controls.each(function() {
        var $control = $(this);

        $control.attr({
          'aria-controls': $control.attr('href').split('#')[1],
          role: 'tab',
          tabindex: -1
        });
      });

      this.$controls.on({
        click: this.events.click.bind(this),
        focus: this.events.focus.bind(this),
        keydown: this.events.keydown.bind(this)
      });

      this.$panels.each(function() {
        var $panel = $(this);

        $panel.attr({
          'aria-labelledby': 'tab-' + $panel.attr('id'),
          role: 'tabpanel'
        });
      });

      this.$container.addClass('js-tabs');
    }
  };

  var $container = $('.tabs');

  if ($container.length) {
    new AriaTabs({
      $container: $container,
      $list: $container.find('.tabs-list'),
      $panels: $container.find('.tabs-panel')
    });
  }
})(window, jQuery);
