# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".vote-create-a").click ->
    $.ajax vote_create_path,
      type: 'POST'
      data: { 
        voteable_id: $(this).attr("voteable_id"), 
        voteable_type: $(this).attr("voteable_type"),
        is_like: $(this).attr("is_like")
      }
