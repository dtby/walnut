# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  title            :string(255)
#  body             :text(65535)
#  subject          :string(255)
#  user_id          :integer          not null
#  parent_id        :integer
#  lft              :integer
#  rgt              :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  #点赞功能
  acts_as_votable
  
  validates :body, :presence => true
  validates :user, :presence => true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_votable

  belongs_to :commentable, :polymorphic => true

  # NOTE: Comments belong to a user
  belongs_to :user

  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, user_id, comment)
    new \
      :commentable => obj,
      :body        => comment,
      :user_id     => user_id
  end

  #helper method to check if a comment has children
  def has_children?
    self.children.any?
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end

  #根据添加的对象的类名已经添加对象的id添加评论
  #返回评论的对象
  def self.add_comment commentable_name, commentable_id, body
    promise_class = ["TaskCategory", "Task"]
    commentable = nil
    if promise_class.include? commentable_name
      commentable = eval("#{commentable_name}.where(id: #{commentable_id}).first")
      if commentable.present?
        comment = Comment.build_from( commentable, current_user.id, body)
        comment.save
      end
    end
    commentable
  end

  #保存创建等操作生成的评论
  def self.add_comment_by_commentable commentable, type
    body = get_comment_body commentable, type
    comment = Comment.build_from( commentable, current_user.id, body)
    comment.save
  end

  def self.get_comment_body commentable, type
    case type.try(:to_sym)
    when :create
      name = {"Announce" => "公告", "TaskCategory" => "任务列表", "Task" => "任务"}
      "创建了#{name[commentable.class.try(:to_s)]}"
    when :move
      "移动任务到 #{commentable.try(:task_category).try(:name)}"
    when :assign
      "把任务分配给 #{commentable.try(:get_principal_user).try(:show_name)}"
    when :settime
      "将截止日期设置为 #{commentable.try(:end_time).try(:strftime,'%Y年%m月%日')}"
    when :waiting
      "把任务置为”待办“"
    when :doing
      "开始了任务"
    when :completed
      "完成了任务"
    when :acceptance
      "验收了任务"
    when :level
      "将优先级设置为 #{Task::Level[commentable.try(:level).try(:to_sym)]}"
    else
      ""      
    end
  end

end
