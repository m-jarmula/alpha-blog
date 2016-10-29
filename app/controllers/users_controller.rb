class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:update, :edit]
  
  def index 
    @users = User.paginate(page: params[:page], per_page: 2)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "You hace been sugned up"
      redirect_to articles_path
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
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if !logged_in? || @user != current_user
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end
end