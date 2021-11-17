import $ from 'jquery'

$(document).on('turbolinks:load', function() {
  $('.color_field').on('change', function() {
    if($(this).find(":selected").text() == "Other")
    {
      $('.color_detail').removeClass("d-none")
    }
    else
    {
      $('.color_detail').addClass("d-none")
    }
  });
});
