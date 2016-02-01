class PerformancesController < ApplicationController
	before_action :set_tour
	before_action :set_performance, except: [:new, :create]


  def index
  	@performances = Performance.all
  	# if current_user and current_user.type == "Host"
  	# 	@pending = Performance.all.where(status: "pending").where(requester_id: @tour.band_id);
  	# end
  end

  # def new
  # 	if current_user and current_user.type == "Band"
  # 		@performance = Performance.new
  # 	else
  # 		flash[:errors] = "Please log in as band."
  # 		redirect_to login_path
  # 	end
  # end

  # def create
  # 	if current_user and current_user.type == "Band"
  # 		update_performance_params = performance_params
  # 		update_performance_params["status"] = "scheduled"
  # 		@performance = current_user.performances.new(update_performance_params)
  # 		@tour.performances << @performance
  # 		if @performance.save
#   			flash[:notice] = "Success"
#   			redirect_to tour_path(@tour)
#   		else
#   			flash[:errors] = @performance.errors.full_messages.join(", ")
#   			redirect_to new_tour_performance_path(@tour)
#   		end
#   	else
#   		redirect_to login_path
#   	end
#   end

#   def edit

#   end
private

	def performance_params 
		params.require(:performance).permit(:requester_id, :performance_date, :location, :band_id, :tour_id, :host_id, :status, :agree)
	end


  def set_performance
    performance_id = params[:id]
    @performance = Performance.find_by_id(performance_id)
  end

	def set_tour
	  tour_id = params[:tour_id]
	  @tour = Tour.find_by_id(tour_id)
	end
end
