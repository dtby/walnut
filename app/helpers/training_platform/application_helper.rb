module TrainingPlatform::ApplicationHelper

  #根据当前任务状态返回对应下拉
  def staus_dropdown state
    dropdown = ["<li data-status = 'wait'>待办中</li>",
      "<li data-status = 'do'>进行中</li>",
      "<li data-status = 'complete'>已完成</li>",
      "<li data-status = 'accept'>验收通过</li>",
      "<li data-status = 'fail'>验收失败</li>"]

    case state
    when "waiting"
      dropdown[1] << dropdown[2]
    when "doing"
      dropdown[0] << dropdown[2]
    when "completed"
      dropdown[0] << dropdown[1] << dropdown[3] << dropdown[4]
    when "acceptance"
      dropdown[0] << dropdown[1] << dropdown[2] << dropdown[3]
    end
  end

end
