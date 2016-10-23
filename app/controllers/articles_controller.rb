class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def edit
    @article = Article.find(params[:id])
  end    
  
  def create
    @article = Article.new(article_params params)
    if @article.save
      flash[:notice] = "Article was created"
      redirect_to article_path(@article)
    else
      render :new
    end
  end
  
  def destroy
    Article.find(params[:id]).destroy
    flash[:notice] = "Message was succesfully deleted"
    redirect_to articles_path
  end
  
  private
  def article_params(params)
    params.require(:article).permit(:title, :description)
  end
end