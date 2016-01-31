class ShowsController < ApplicationController

	before_action :find_show, only: [:show, :edit, :update, :destroy]
  before_action :matching_performance, only: :index

  def index
    ## need to be working on
    if current_user and current_user.type == "Band"
      @shows = []
      @match_performances.each do |match_performance|
        b = Show.all.where(location: match_performance.location).where(show_date: match_performance.performance_date)
        if b.any?
          @shows << b
        end
      end
      # @shows.uniq! { |show| show.first.id }
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
  			render action: :view
  		end
  	else
  		redirect_to login_path
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
      @match_performances = []
      Show.all.each do |show|
        a = current_user.performances.where(location: show.location).where(performance_date: show.show_date)
        if a.any?
          @match_performances << current_user.performances.where(location: show.location).where(performance_date: show.show_date) 
        end
      end
    end 
  end
end
