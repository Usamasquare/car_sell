import $ from 'jquery'
$(document).on('turbolinks:load', function() {
  $(".show").click(function() {
    $(".test").toggle(100);
    $(".test").removeClass("d-none");
  });
})
