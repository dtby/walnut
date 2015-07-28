module Api
	class UsersController < ApplicationController
		def index
			@users = User.all
			render json: @users.to_json(only: [:name])
		end
	end
end