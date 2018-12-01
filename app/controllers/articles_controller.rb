class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
  	article_params = params.require(:article).permit(:title, :text) #permit stosujemy tylko wtedy, gdy modyfikujemy rekord
  	@article = Article.new(article_params)
      if @article.save
        redirect_to article_path(@article)
      else
        render 'new'
      end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
  	article_params = params.require(:article).permit(:title, :text)
    @article = Article.find(params[:id])
	  if @article.update(article_params)
	    redirect_to article_path(@article)
	  else
		render 'edit'
	  end
  end

end