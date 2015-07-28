$ ->
  #点击任务显示详情
  $(".task-link").click ->
    $(".task-list-row").removeClass("active")
    $(this).find(".task-list-row").addClass("active")

  #状态dropdown点击后，将其移入对应状态栏显示
  $(".task-state-dropdown li").click -> 
    task = $(this).parent(".task-state-dropdown").attr("data-task")
    state = $(this).attr("data-status")

    $.ajax change_state_path,
      type: 'post'
      data: { task_id: task, state: state } 

    # #当前task内容块
    # currentTaskContent = $(this).parents(".task-list-content")

    # #添加到新state列表的dcoument
    # appendDoc = ""

    # switch state
    #   when "wait", "fail"
    #     appendDoc = $(".task-list-content").eq(0)
    #   when "do" 
    #     appendDoc = $(".task-list-content").eq(1)
    #   when "complete" 
    #     appendDoc = $(".task-list-content").eq(2)
    #   when "accept"
    #     appendDoc = $(".task-list-content").eq(3)
    #   else return

    
    # #复制需移动的task
    # add = $("#taskListLink" + task).clone(true)

    # #判断原状态是否没有了任务，没有任务则显示对应提示
    # if $("#taskListLink" + task).siblings("a").length is 0
    #   currentTaskContent.find(".task-list-blank").show()


    # #删除原来state的task
    # $("#taskListLink" + task).remove()

    # #隐藏新state栏的没有任务的提示
    # appendDoc.find(".task-list-blank").hide()
    # #将任务移入新的state一栏
    # add.appendTo(appendDoc)

  