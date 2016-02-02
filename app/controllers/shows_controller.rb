class ShowsController < ApplicationController

	before_action :find_show, only: [:show, :edit, :update, :destroy]
  before_action :matching_performance, only: [:index, :show, :update]

  def index
    if current_user and current_user.type == "Band" and @match_shows.any?
      @match_shows
    else
      if current_user.type == "Band"
        redirect_to band_path(current_user)
      elsif current_user.type == "Host"
        redirect_to host_path(current_user)
      end
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
    @request = Request.new
    @confirmed_requests = Request.where({status: "confirmed", show_id: @show.id})
    @pending_requests = Request.all.where({status: "pending", show_id: @show.id})
    if current_user
      if current_user.type == "Band" and @match_shows.include?(@show)
        host_requests_for_band = Request.where({requester_id: @show.host.id, show_id: @show.id, status: "pending"})
        @host_single_request = host_requests_for_band.select { |hostreq| hostreq.performance.band_id == current_user.id }
        @band_request = Request.where({requester_id: current_user.id, show_id: @show.id, status: "denied"})
        @show
      elsif current_user.type == "Host" and current_user.id == @show.host_id
        @show
      else
        if current_user.type == "Band"
          flash[:errors] = "You can only find venue in city you have performance."
          redirect_to band_path(current_user) and return
        else 
          flash[:errors] = "You can only view show you created."
          redirect_to host_path(current_user) and return
        end
      end
    else
      redirect_to signup_path
    end
  end

  def edit
  	unless current_user.id == @show.host_id
  		redirect_to host_path(current_user)
  	end
  end

  def update
    @pending_performances = Performance.all.where({status: "pending", show_id: @show.id})
    if current_user.type == "Band" and @match_shows.include?(@show)
      @performance = current_user.performances.where(performance_date: @show.show_date)[0]
      @performance.update_attributes({status: "pending", requester_id: current_user.id, show_id: @show.id})
      redirect_to band_path(current_user)
    # elsif current_user.type == "Host" and current_user.id == @show.host_id and @show.slots != 0
    #   # a = params[:id]
    #   # byebug # still in progress
    #   @show.update_attributes(slots: @show.slots - 1)
    #   redirect_to shows_path(@show)
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
