class ToursController < ApplicationController

	before_action :find_tour, only: [:show, :edit, :update, :destroy]

  def index
  	@tours = Tour.all
  end

  def new
  	if current_user and current_user.type == "Band"
  		@tour = Tour.new
      3.times { @tour.performances.build }
  	else
  		flash[:errors] = "Please login as a band to create tour."
  		redirect_to login_path
  	end
  end

  def create
  	if current_user and current_user.type == "Band"
  		@tour = current_user.tours.new(tour_params)
      byebug
  		if @tour.save 
  			flash[:notice] = "Successfully created a tour."
  			redirect_to tour_path(@tour)
  		else
  			flash[:errors] = @tour.errors.full_messages.join(", ")
  			render action: :view
  		end
  	else
  		redirect_to login_path
  	end
  end

  def show
  	unless current_user.id == @tour.band_id
  		redirect_to host_path(current_user.id)
  	end
  end

  def edit
  	unless current_user.id == @tour.band_id
  		redirect_to tour_path(@tour)
  	end
  end

  def update
  	if current_user.id == @tour.band_id
  		if @tour.update_attributes(tour_params)
  			flash[:notice] = "Successfully edit the tour."
  			redirect_to tour_path(@tour)
  		else
  			flash[:errors] = @tour.errors.full_messages.join(", ")
  			redirect_to edit_tour_path(@tour)
  		end
  	else
  		redirect_to tour_path(@tour)
  	end
  end

  def destroy
  	if current_user.id == @tour.band_id
  		@tour.destroy
  		flash[:notice] = "Successfully delete a tour."
  		redirect_to band_path(current_user)
  	else
  		redirect_to tour_path(@tour)
  	end
  end

private
	def tour_params
		params.require(:tour).permit(:name, :band_id, performances_attributes: [:location, :performance_date])
	end

	def find_tour
		@tour =  Tour.find(params[:id])
	end
end
