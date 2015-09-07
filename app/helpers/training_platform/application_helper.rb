module TrainingPlatform::ApplicationHelper

  #根据当前任务状态返回对应下拉
  #state：状态，path：生成的路径
  def staus_dropdown state,path
    dropdown = []
    
    dropdown.push content_tag('li', link_to('待办中', (path + "?state=wait"), remote: true, format: :js) )
    dropdown.push content_tag('li', link_to('进行中', (path + "?state=do"), remote: true, format: :js) )
    dropdown.push content_tag('li', link_to('已完成', (path + "?state=complete"), remote: true, format: :js) )
    dropdown.push content_tag('li', link_to('验收通过', (path + "?state=accept"), remote: true, format: :js) )
    dropdown.push content_tag('li', link_to('验收失败', (path + "?state=fail"), remote: true, format: :js) )

    case state
    when "waiting"
      dropdown[1] << dropdown[2]
    when "doing"
      dropdown[0] << dropdown[2]
    when "completed"
      dropdown[0] << dropdown[1] << dropdown[3] << dropdown[4]
    when "acceptance"
      dropdown[0] << dropdown[1] << dropdown[2] << dropdown[4]
    end
  end


  # 当前用户是否是项目成员
  def project_member?(project)
    UserProject.where(user_id: current_user.id, project_id: project.id, invite: true).present?
  end
end
