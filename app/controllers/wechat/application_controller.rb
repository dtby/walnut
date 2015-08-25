class Wechat::ApplicationController < ApplicationController
	before_action :authenticate_user!
	layout 'wechat'
end