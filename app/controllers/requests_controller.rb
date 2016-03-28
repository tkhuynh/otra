class RequestsController < ApplicationController
  def create
    request_params = params.require(:request).permit(:status, :show_id, :requester_id, :performance_id)
    request_alread_made_by_host = Request.where({requester_id: current_user.id, performance_id: request_params[:performance_id]})
    @request = Request.create(request_params)
    if current_user.type == "Host"
    	flash[:notice] = "Your request has sent to " + @request.performance.band.name
    	redirect_to host_dashboard_path
    else
    	flash[:notice] = "Your request has sent to " + @request.show.venue
    	redirect_to band_dashboard_path
    end
  end

  def update
  end
end
