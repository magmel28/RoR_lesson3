# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  like_count = $('#like_count').text()
  like_count = parseInt(like_count, 10) + 1
  $("#like_btn").on "click", () ->
    $('#like_count').text(like_count)

