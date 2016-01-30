class ShowsController < ApplicationController

	before_action :find_show, only: [:show, :edit, :update, :destroy]

  def index
  	@show = Show.all
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
      byebug
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

  def show
  	unless current_user.id == @show.host_id
  		redirect_to host_path(current_user)
  	end
  end

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
end
