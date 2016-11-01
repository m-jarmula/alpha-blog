class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:show]
  
  def index
    @categories = Category.paginate(page: params[:page],per_page: 5)
  end
  
  def new
    @category = Category.new
  end
  
  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created"
      redirect_to categories_path
    else
      render :new
    end
  end
  
  private
  
  def set_category
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = "You can't perform this action"
      redirect_to root_path
    end
  end
end