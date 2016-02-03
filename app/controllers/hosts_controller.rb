class HostsController < ApplicationController
	def show
		@host = Host.find(params[:id])
		
	end

	def dashboard
		if current_user and current_user.type == "Host" 
			@host = Host.find(current_user.id)
		  all_shows = current_user.shows
		  respond_to do |format|
		  	format.html{render :dashboard}
		  	format.json{render json: all_shows}
		  end
		else
			redirect_to login_path
		end
	end
end



