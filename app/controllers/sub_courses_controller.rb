class SubCoursesController < ApplicationController
	def show
		@course = Course.find_by(id: params[:course_id])
		@sub_courses = @course.sub_courses
		@sub_course = SubCourse.find(params[:id])
		@comment = Comment.new
		@comments = @sub_course.root_comments
	end

	def create
		@user = current_user
		@sub_course = SubCourse.find(params[:sub_course_id])
		 @comment = Comment.build_from( @sub_course, @user.id, params[:user_comment] )
		if @comment.save
			render :show
		else
			render :show
		end

	end

	def detail
		
	end

end
