class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:update, :edit]
  before_action :require_admin, only: [:destroy]
  def index 
    @users = User.paginate(page: params[:page], per_page: 2)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You hace been sugned up"
      redirect_to user_path(@user)
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your account has been changed"
      redirect_to articles_path
    else
      render :edit
    end
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:danger] = "User and all articles created by user have been deleted"
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if (!logged_in? || @user != current_user) && !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end
  
  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only admin can performe this action"
      redirect_to root_path
    end
  end
end