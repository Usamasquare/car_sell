import $ from 'jquery';

$(document).on('turbolinks:load', function () {
  $('.show').click(function () {
    $('.toggle-search').toggleClass('d-none');
  });
});
