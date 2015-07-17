# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
voteable = (obj)->
  $.ajax vote_create_path,
    type: 'POST'
    data: { 
      voteable_id: obj.attr("voteable_id"), 
      voteable_type: obj.attr("voteable_type"),
      style_type: obj.attr("style_type")
    }

$ ->
  #实现招聘列表收藏
  $(".vote-create-a").click ->
    voteable($(this))