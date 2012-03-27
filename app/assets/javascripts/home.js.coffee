# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
    $("#getting-started").modal('show')
    $("input.date_picker").datetimepicker({ dateFormat: 'yy-mm-dd', timeFormat: 'hh:mm' })


#jQuery ->
#  $(".nav li a").click (e) ->
#    $this = $(this)
#    $this.addClass "active"  unless $this.hasClass("active")
#    e.preventDefault()
