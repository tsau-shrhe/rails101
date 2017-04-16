class WelcomeController < ApplicationController
	def index
		flash[:alert] = "警告"
	end
end
