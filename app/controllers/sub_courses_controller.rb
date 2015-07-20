class SubCoursesController < ApplicationController
	def show
		@course = Course.find_by(id: params[:course_id])
		@sub_courses = @course.sub_courses
		@sub_course = SubCourse.find(params[:id])
		@comment = Comment.new
		@comments = @sub_course.root_comments.order("created_at DESC").page(params[:page])
		respond_with @comments
	end

	def create
		user = current_user
		@comments = SubCourse.save_comment_return_comments user,params
		respond_with @comments
	end

	def detail
		
	end

end
