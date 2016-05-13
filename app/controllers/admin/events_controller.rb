#管理後台的controller
class Admin::EventsController < ApplicationController

	#簡單的http驗證
	before_action :authenticate
	layout "admin"

	#...

	protected

	def authenticate
		authenticate_or_request_with_http_basic do |user_name , password|
			user_name == "username" && password == "password"
		end		
	end
end
