# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  #实现面试列表收藏
  $(".int-create-a").unbind("click")
  $(".int-create-a").click ->
    $.ajax int_create_path,
      type: 'POST'
      data: { 
        intable_id: $(this).attr("intable_id"), 
        intable_type: $(this).attr("intable_type"),
        style_type: $(this).attr("style_type")
      }