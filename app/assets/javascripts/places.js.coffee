# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $(".chzn-select").chosen();
  $(".span14.thumbnails > :nth-child(4n+4)").find(".place_photo").removeClass().addClass("place_photo_last_right")
  $(".place_photo").popover()
  $(".place_photo_last_right").popover({placement : 'left'})
  $(".icon_tooltip").tooltip();
