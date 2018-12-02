class ArticlesController < ApplicationController

  def index
  	# binding.pry
    @articles = Article.all.order(id: :desc)
  end

  def new
    @article = Article.new
  end

  def create
  	# binding.pry https://gist.github.com/lfender6445/9919357
  	# https://github.com/rweng/pry-rails
  	# article_params = params.require(:article).permit(:title, :text) #permit stosujemy tylko wtedy, gdy modyfikujemy rekord
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
  	# article_params = params.require(:article).permit(:title, :text)
    @article = Article.find(params[:id])
	  if @article.update(article_params)
	    redirect_to article_path(@article)
	  else
		render 'edit'
	  end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title,:text)
  end

end