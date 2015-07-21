# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  #简历投递
  $(".recruitment-deliver").unbind("click")
  $(".recruitment-deliver").click ->
    $.ajax deliver_path,
      type: 'POST'
      data: { 
        recruitment_id: $(this).attr("deliver_id"), 
        style_type: $(this).attr("style_type")
      }