class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all    
  end

  def show
    @registrations = @user.registrations
    @liked_events = @user.liked_events
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Account Successfully Created!"
    else
      render :new
    end
  end

  def edit
  end

  def update 
    if @user.update(user_params)
      redirect_to @user, notice: "Account Successfully Updated!"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, alert: "Account Successfully Deleted!"
  end

  private

  def find_user
    @user = User.find_by!(slug: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

  def require_correct_user
    unless current_user?(@user)
      redirect_to root_url, alert: "Unauthorized Access!"
    end
  end
end
