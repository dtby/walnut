module Admin
	class AppliesController < Admin::ApplicationController
		before_action :apply_params, only: [:update]
		before_action :set_apply, only: [:edit, :update, :destroy]
		before_action :set_applies, only: [:index, :update]
		def index
			respond_to do |format|
				format.xls {
					send_data( xls_content_for(@applies),
						:type => "text/excel;charset=utf-8; header=present",
						:filename => "#{params[:train_name].nil? ? "全部学生" : Apply.find_by(train_name: params[:train_name]).train_name}_#{Time.now.strftime("%F %H%M%S")}.xls" )
				}
				format.html
			end
		end

		def edit
		end

		def update
			if @apply.update(apply_params)
				redirect_to admin_applies_path
			else
				render :edit
			end
		end

		def destroy
			if @apply.present?
				@apply.destroy
			end
			redirect_to admin_applies_path
		end

		private
		def apply_params
			params.require(:apply).permit(:openid, :name,  :sex, :phone, :email, :qq, :address, :situation, :degree, :way, :train_name, :school_name)
		end

		def set_apply
			@apply = Apply.find(params[:id])
		end

		def set_applies
			@applies = Apply.students(params[:train_name]).order(created_at: :asc)
		end
		#xls文件格式内容
		def xls_content_for(objs)
			xls_report = StringIO.new
			book = Spreadsheet::Workbook.new
			sheet1 = book.create_worksheet :name => "报名统计"

			blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
			sheet1.row(0).default_format = blue

			sheet1.row(0).concat %w{序号 姓名 性别 报名课程 手机号码 QQ 邮箱 就业状况 教育状况 所在院校 了解渠道 报名时间}
			count_row = 1
			objs.each do |obj|
				sheet1[count_row, 0] = count_row
				sheet1[count_row, 1] = obj.name
				sheet1[count_row, 2] = Apply::SEX[obj.sex.to_sym]
				sheet1[count_row, 3] = Apply::TRAIN_NAME[obj.train_name.to_sym]
				sheet1[count_row, 4] = obj.phone
				sheet1[count_row, 5] = obj.qq
				sheet1[count_row, 6] = obj.email
				sheet1[count_row, 7] = Apply::SITUATION[obj.situation.to_sym]
				sheet1[count_row, 8] = Apply::DEGREE[obj.degree.to_sym]
				sheet1[count_row,9] = obj.school_name
				sheet1[count_row, 10] = Apply::WAY[obj.way.to_sym]
				sheet1[count_row, 11] = obj.created_at.strftime("%F %H:%M")
				count_row += 1
			end

			book.write xls_report
			xls_report.string
		end
	end
end