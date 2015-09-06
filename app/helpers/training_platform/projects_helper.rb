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

  def show_project_desc(project)
    if project.default?
      "（总任务：#{project.tasks.count} 已完成：#{project.tasks.completes.count}
        待办中：#{project.tasks.waits.count} 验收通过：#{project.tasks.acceprances.count} ）"
    else
      project.description
    end
  end
end
