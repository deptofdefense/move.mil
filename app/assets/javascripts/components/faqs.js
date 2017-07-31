(function(window, $) {
  'use strict';

  var tagCheckboxes = document.querySelectorAll('#faq-filters input'),
      faqAccordions = document.querySelectorAll('#faq-accordions .faq-accordion');

  var intersectArrays = function(arr1, arr2) {
    var v1, v2;
    for (var i1 = 0; i1 < arr1.length; i1++) {
      var v1 = arr1[i1];
      for (var i2 = 0; i2 < arr2.length; i2++) {
        var v2 = arr2[i2];
        if (v1 == v2) {
          return true;
        }
      }
    }
    return false;
  };

  var checkboxOnClick = function() {
    var categories = [];
    for (var i = 0; i < tagCheckboxes.length; i++) {
      var ck = tagCheckboxes[i];
      if (ck.checked)
        categories.push(tagCheckboxes[i].value);
    }

    // if nothing is checked, show all the FAQs
    if (categories.length == 0) {
      for (var i = 0; i < faqAccordions.length; i++) {
        faqAccordions[i].style.display = "";
      }
      return;
    }

    for (var i = 0; i < faqAccordions.length; i++) {
      var acc = faqAccordions[i];
      var tags = acc.getAttribute("data-categories").split(",");

      if (intersectArrays(categories, tags))
        // a tag matched an enabled category, so make the accordion visible
        acc.style.display = "";
      else
        // no tags matched an enabled category, so hide the accordion
        acc.style.display = "none";
    }
  };

  if (tagCheckboxes.length && faqAccordions.length) {
    for (var i = 0, j = tagCheckboxes.length; i < j; i++) {
      tagCheckboxes[i].onclick = checkboxOnClick;
    }
  }
})(window, jQuery);
