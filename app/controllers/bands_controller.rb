class BandsController < ApplicationController
	def show
		@band = Band.find(params[:id])
	end

	# def update
	# 	@band = Band.find(params[:id])
	# 	if @band.update_attributes(band_params)
	# 	  flash[:notice] = "Successfully updated profile."
	# 	  redirect_to band_path(@band)
	# 	else
	# 	  flash[:error] = @band.errors.full_messages.join(', ')
	# 	  redirect_to edit_user_path(@band)
	# 	end
	# end
	
	def dashboard
		if current_user and current_user.type == "Band"
			@band = Band.find(current_user.id)
		else
			redirect_to login_path
		end
	end
end

# private

# def band_params
#   params.require(:band).permit(:name, :email, :type, :password, :password_confirmation, :description, :location, :avatar)
# end

# def find_band
#   @band = Band.find(params[:id])
# end
