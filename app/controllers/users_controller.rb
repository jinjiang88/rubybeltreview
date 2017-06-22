class UsersController < ApplicationController

skip_before_action :require_login, only: [:new, :create]
before_action :require_correct_user, only: [:edit, :show, :update, :destroy]

  def new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def create
    @user = User.new user_params
    if @user.save
        session[:user_id] = @user.id
        redirect_to "/events"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update user_params
      redirect_to "/events"
    else
      flash[:errors] = @user.errors.full_messages     
      redirect_to "/users/#{@user.id}/edit"
    end
  end
private

    def require_correct_user
      if current_user != User.find(params[:id])
        redirect_to "/events"
      end
    end

   def user_params
     params.require(:user).permit(:fname, :lname, :email, :location, :state, :password, :password_confirmation)
   end
end
