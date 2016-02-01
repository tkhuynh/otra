class BandsController < ApplicationController
	def show
		@band = Band.find(params[:id])
	end
	
	def dashboard
		if current_user and current_user.type == "Band"
			@band = Band.find(current_user.id)
		else
			redirect_to login_path
		end
	end
end

