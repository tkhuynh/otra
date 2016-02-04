class PerformancesController < ApplicationController
	before_action :set_tour
	before_action :set_performance, except: [:new, :create]
  before_action :matching_performances, only: [:index, :show]

  def index

    if current_user.type == "Host" and @match_performances.empty?
      flash[:errors] = "There aren't any performances matches any of your shows."
      redirect_to host_path(current_user)
    elsif current_user.type == "Host" and @match_performances.any?
      @match_performances.sort_by! {|x| [x[0] - Date.today]}
    elsif current_user.type == "Band"
      redirect_to band_path(current_user)
    end
  end


  def show
    @request = Request.new
    @confirmed_request = Request.where({status: "confirmed", performance_id: @performance.id})[0]
    @pending_requests = Request.all.where({status: "pending", performance_id: @performance.id})
    if current_user
      if current_user.type == "Host" and @match_performances.any? {|performance| performance = @performance}
        @host_request = Request.where({requester_id: current_user.id, performance_id: @performance.id})
        @performance
      elsif current_user.type == "Band" and current_user.id == @performance.band_id
        @performance
      elsif current_user.type == "Host" and @match_performances.any? {|performance| performance = @performance} == false
        flash[:errors] = "You can only see performances in your city."
        redirect_to host_path(current_user) and return
      elsif current_user.type == "Band" and current_user.id != @performance.band_id
        flash[:errors] = "You can only view performance you created."
        redirect_to band_path(current_user) and return
      end
    else
      redirect_to signup_path
    end

  end



  def update
    this_show_id = params[:performance][:show_id]
    performance = Performance.find(params[:id])
    show_confirmed_requests = Request.where({status: "confirmed", show_id: this_show_id})
    request = Request.where({status: "pending", show_id: this_show_id, performance_id: performance.id})[0]
    if current_user && current_user.id != request.requester_id && performance.status == "scheduled"
      if params[:commit] == "Confirm"
        performance.update_attributes({status: "confirmed"})
        request.update_attributes({status: "confirmed"})
        if current_user.type == "Host"
          if show_confirmed_requests.count == Show.find(this_show_id).slots
            show_pending_requests = Request.where({status: "pending", show_id: this_show_id})
            show_pending_requests.each do |pending_request|
              pending_request.update_attributes({status: "denied"})
            end
            redirect_to show_path(request.show_id)
          else
            redirect_to show_path(request.show_id)
          end
        else
          all_requests = Request.where({performance_id: request.performance_id, status: "pending"})
          all_requests.each do |each_request|
            each_request.update_attributes({status: "denied"})
          end
          flash[:notice] = "Performance on " + performance.performance_date.to_s + " will be at " + request.show.venue
          redirect_to dashboard_path
        end
      elsif params[:commit] == "Deny"
        if current_user.type == "Host"
          request.update_attributes({status: "denied"})
          redirect_to show_path(request.show_id)
        else
          flash[:notice] = "You have denied a request from " + request.show.venue
          request.update_attributes({status: "denied"})
          redirect_to performance_path(performance)
        end
      end 
    end
  end

private

	def performance_params 
		params.require(:performance).permit(:requester_id, :performance_date, :location, :band_id, :tour_id, :host_id, :status, :agree)
	end

  def matching_performances
    if current_user and current_user.type == "Host"
      @host_matched_performances = Performance.where({status: "scheduled", location: current_user.location})
      @match_performances = []
      # byebug
      current_user.shows.each do |show|
        match_performances = @host_matched_performances.where({ performance_date: show.show_date}).group_by {|performance| performance.performance_date}
        if match_performances.any?
          match_performances.each do |performance|
            @match_performances << performance
          end
        end
      end
    end
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
