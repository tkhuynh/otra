class UsersController < ApplicationController
	before_action :find_user, except: [:index, :new, :create]
  before_action :authorize, except: [:show, :new, :create]

  def new
    @role = ["Host", "Band"]
    @user = User.new
  end

  def create
    #don't let current user create new account
    if !current_user 
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Successfully signed up."
        if @user.type == "Host"
          redirect_to host_path(@user)
        elsif @user.type == "Band"
          redirect_to band_path(@user)
        end
      else
        flash[:error] = @user.errors.full_messages.join(', ')
        redirect_to signup_path
      end
    elsif current_user and current_user.type == "Host"
      redirect_to host_path(current_user)
    elsif current_user and current_user.type == "Band"
      redirect_to band_path(current_user)
    end
  end

  def edit
    #don't let current user see edit form of other user profile
    #see private method
    unless current_user == @user
      if current_user.type == "Host"
        flash[:notice] = "You can only edit your profile."
        redirect_to host_path(current_user)
      elsif current_user.type == "Band"
        flash[:notice] = "You can only edit your profile."
        redirect_to band_path(current_user)
      end
    end
  end

  def update
    #only current user can update his own account
    if current_user == @user
      if @user.update_attributes(user_params)
        flash[:notice] = "Successfully updated profile."
        if current_user.type == "Host"
          redirect_to host_path(@user)
        elsif current_user.type == "Band"
          redirect_to band_path(@user)
        end
      else
        flash[:error] = @user.errors.full_messages.join(', ')
        redirect_to edit_user_path(@user)
      end
    else 
      #if someone else redirect to signup page
      redirect_to signup_path
    end
  end

  def destroy
    if current_user == @user
      @user.destroy
      session[:user_id] = nil
      flash[:notice] = "Successfully delete profile."
      redirect_to root_path
    else
      flash[:error] = "You can't delete someone else's profile." 
      redirect_to user_path(current_user)
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :type, :password, :password_confirmation, :description, :location)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
