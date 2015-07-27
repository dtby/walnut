$ ->
  #点击任务显示详情
  $(".task-link").click ->
    $(".task-list-row").removeClass("active")
    $(this).find(".task-list-row").addClass("active")
  