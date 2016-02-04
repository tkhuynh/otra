class BandsController < ApplicationController

	before_action :band_performances

	def show
		if current_user and current_user.type == "Band"
			@band = Band.find(params[:id])
		else 
			redirect_to login_path
		end
	end

	def dashboard
		if current_user and current_user.type == "Band" 
		  respond_to do |format|
		  	format.html{render :dashboard}
		  	format.json{render json: @all_performances}
		  end
		else
			redirect_to login_path
		end
	end
	private
	def band_performances
		@pending_performances = []
		current_user.performances.each do |performance|
			pending = performance.requests.where(status: "pending")
			if pending.any?
				@pending_performances << pending[0].performance
			end
		end
		@band = Band.find(current_user.id)
	  @all_performances = current_user.performances.group_by {|performance| performance.tour_id}.to_a
	  @all_performances.sort!
	end
end

