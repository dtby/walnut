module TrainingPlatform::ProjectsHelper

  #  项目背景色
  def project_bc(project)
    if project.default?
      'blue-bg'
    elsif project.follow?
      'purple-bg'
    elsif project.together?
      'yellow-bg'
    end
  end

  # index 项目描述显示
  def show_project_desc(project)
    if project.default?
      "（总任务：#{project.tasks.count} 已完成：#{project.tasks.completes.count}
        待办中：#{project.tasks.waits.count} 验收通过：#{project.tasks.acceprances.count} ）"
    else
      project.description
    end
  end

  # 项目操作
  def project_ops(project)
    ops = ""
    if project.follow?
      ops = link_to("javascript:void(0);"){image_tag("iconfont-copy.svg", width: "20px") }
    elsif project.together?
      ops = link_to("javascript:void(0);"){image_tag("iconfont-apply.svg", width: "20px") }
      ops += link_to("javascript:void(0);"){image_tag("iconfont-copy.svg", width: "20px") }
    end
    ops
  end
end
