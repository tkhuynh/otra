class RequestsController < ApplicationController
  def create
    request_params = params.require(:request).permit(:status, :show_id, :requester_id, :performance_id)
    @request = Request.create(request_params)
    if current_user.type == "Host"
    	flash[:notice] = "Your request has sent to " + @request.performance.band.name
    	redirect_to show_path(@request.show_id)
    else
    	flash[:notice] = "Your request has sent to " + @request.show.venue
    	redirect_to performance_path(@request.performance_id)
    end
  end

  def update
  end
end
