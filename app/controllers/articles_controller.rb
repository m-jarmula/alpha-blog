class ArticlesController < ApplicationController
  before_action :current_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end
  
  def new
    @article = Article.new
  end
  
  def show
  end
  
  def edit
  end    
  
  def update
    if @article.update(article_params)
      flash[:success] = "The article was successfully updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article was created"
      redirect_to article_path(@article)
    else
      render :new
    end
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Message was succesfully deleted"
    redirect_to articles_path
  end
  
  private
  
  def current_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :description)
  end
end