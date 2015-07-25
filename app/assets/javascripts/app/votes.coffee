# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  #实现招聘列表收藏
  $(".vote-create-a").unbind("click")
  $(".vote-create-a").click ->
    $.ajax vote_create_path,
      type: 'POST'
      data: { 
        voteable_id: $(this).attr("voteable_id"), 
        voteable_type: $(this).attr("voteable_type"),
        style_type: $(this).attr("style_type"),
        scope: $(this).attr("scope")
      }