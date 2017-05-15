//= require 'jquery/jquery'
//= require 'uswds/uswds'

var $form = $('#moving-allowances-form');

if ($form) {
  var $payGradeInput = $('#pay-grade'),
      $container = $('#moving-allowances'),
      $tables = $('.moving-allowances-table');

  $form.removeAttr('hidden');

  $container.attr({
    hidden: true,
    tabindex: -1
  });

  $tables.each(function() {
    $(this).attr('hidden', true);
  });

  $form.on('submit', function(event) {
    event.preventDefault();

    var payGradeInputValue = $payGradeInput.val();

    if (payGradeInputValue.length) {
      $container.removeAttr('hidden');

      $tables.each(function() {
        var $table = $(this);

        if ($table.data('payGrade') === payGradeInputValue) {
          $table.removeAttr('hidden');

          $container.trigger('focus');
        } else {
          $table.attr('hidden', true);
        }
      });
    } else {
      $container.attr('hidden', true);
    }
  });
}
