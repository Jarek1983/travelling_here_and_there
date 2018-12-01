class ArticlesController < ApplicationController

  def index

  end

  def new

  end

  def create
  	article_params = params.require(:article).permit(:title, :text) #permit stosujemy tylko wtedy, gdy modyfikujemy rekord
  	@article = Article.new(article_params)
    @article.save
    redirect_to article_path(@article)
  end

  def show
    @article = Article.find(params[:id])
  end

end