class BandsController < ApplicationController

	def show
		if current_user and current_user.type == "Band"
			@band = Band.find(params[:id])
		else 
			redirect_to login_path
		end
	end

	def dashboard
		if current_user and current_user.type == "Band" 
			@band = Band.find(current_user.id)
		  all_performances = current_user.performances
		  respond_to do |format|
		  	format.html{render :dashboard}
		  	format.json{render json: all_performances}
		  end
		else
			redirect_to login_path
		end
	end
end

