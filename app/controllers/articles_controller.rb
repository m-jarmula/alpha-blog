class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params params)
    @article.save
    redirect_to articles_path
  end
  
  private
  def article_params(params)
    params.require(:article).permit(:title, :description)
  end
end