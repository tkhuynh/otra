class RequestsController < ApplicationController
  def create
    request_params = params.require(:request).permit(:status, :show_id, :requester_id, :performance_id)
    # byebug
    @request = Request.create(request_params)
    redirect_to show_path(@request.show_id)
  end

  def update
  end
end
