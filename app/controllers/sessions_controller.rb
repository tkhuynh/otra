class SessionsController < ApplicationController
	def new
		#prevent current user to see login page again
		if current_user and current_user.type == "Host"
			redirect_to host_path(current_user)
		elsif current_user and current_user.type == "Band"
			redirect_to band_path(current_user)
		end
	end

	def create
		@user = User.find_by_email(params[:email])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			if @user.type == "Host"
				#after login redirect Host to profile page
				redirect_to host_path(@user)
			elsif @user.type == "Band"
				#after login redirect to Band profil page
				redirect_to dashboard_path
			end
		else
			flash[:error] = "Incorrect email or password."
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Successfully logged out."
		redirect_to login_path
	end
end
