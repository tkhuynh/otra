class ShowsController < ApplicationController

	before_action :find_show, only: [:show, :edit, :update, :destroy]
  before_action :matching_performance, only: [:index, :show]

  def index
    ## need to be working on
    if current_user and current_user.type == "Band"
      @match_shows
    else
      redirect_to host_path(current_user)
    end
  end

  def new
  	if current_user and current_user.type == "Host"
  		@show = Show.new
  	else
  		flash[:errors] = "Please login as a host to create show."
  		redirect_to login_path
  	end
  end

  def create
  	if current_user and current_user.type == "Host"
  		@show = current_user.shows.new(show_params)
  		if @show.save 
  			flash[:notice] = "Successfully created a show."
  			redirect_to host_path(current_user)
  		else
  			flash[:errors] = @show.errors.full_messages.join(", ")
  			render action: :new
  		end
  	else
  		redirect_to login_path
  	end
  end

  def show
    if current_user and current_user.type == "Band" and @match_shows.include?(@show)
      @show
    else
      flash[:errors] = "You can only find venue in city you have performance."
      redirect_to band_path(current_user)
    end
  end
  # def show
  #   # if a band, find performance date match show date
  # 	unless current_user.id == @show.host_id
  # 		if current_user.type == "Host"
  #       redirect_to host_path(current_user)
  #     elsif current_user.type == "Band"
  #       redirect_to band_path(current_user)
  #     end
  # 	end
  # end

  def edit
  	unless current_user.id == @show.host_id
  		redirect_to host_path(current_user)
  	end
  end

  def update
  	if current_user.id == @show.host_id
  		if @show.update_attributes(show_params)
  			flash[:notice] = "Successfully edit the show."
  			redirect_to host_path(current_user)
  		else
  			flash[:errors] = @show.errors.full_messages.join(", ")
  			redirect_to edit_show_path(@show)
  		end
  	else
  		redirect_to host_path(current_user)
  	end
  end

  def destroy
  	if current_user.id == @show.host_id
  		@show.destroy
  		flash[:notice] = "Successfully delete a show."
  		redirect_to host_path(current_user)
  	else
  		redirect_to host_path(current_user)
  	end
  end

 private
 	def show_params
 		params.require(:show).permit(:venue, :location, :slots, :host_id, :show_date, :booked)
 	end

 	def find_show
 		@show = Show.find(params[:id])
 	end

  def matching_performance
    if current_user and current_user.type == "Band"
      @band_scheduled_performances = current_user.performances.where(status: "scheduled")
      @match_shows = []
      @band_scheduled_performances.each do |performance|
        match_shows = Show.all.where({location: performance.location, show_date: performance.performance_date})
        if match_shows.any?
          match_shows.each do |show|
            @match_shows << show
          end
        end
      end
    end 
  end
end
