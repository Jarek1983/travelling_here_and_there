class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_article, only: [:destroy, :edit, :update]
  
  def index
  	# binding.pry
    @articles = Article.all.order(id: :desc)
    @articles = @articles.where("? = any(tags)", params[:q]) if params[:q].present?
  end

  def new
    @article = Article.new
  end

  def create
  	# binding.pry https://gist.github.com/lfender6445/9919357
  	# https://github.com/rweng/pry-rails
  	# article_params = params.require(:article).permit(:title, :text) #permit stosujemy tylko wtedy, gdy modyfikujemy rekord
  	@article = Article.new(article_params)
    @article.user = current_user
    # @article.user_id = current_user.id
      if @article.save
        flash[:notice] = "You create new article"
        redirect_to article_path(@article)
      else
        render 'new'
      end
  end

  def show
    @comment = Comment.new
    # @article = Article.find(params[:id])
    # find_article
  end

  def edit
    # @article = Article.find(params[:id])
    # if @current_user ||= User.find(session[:user_id]) if session[:user_id]
    return unless authorize_article
  end

  def update
  	# article_params = params.require(:article).permit(:title, :text)
    # @article = Article.find(params[:id])
    # find_article
    return unless authorize_article

	  if  @article.update(article_params)
      flash[:notice] = "You edit article"
	    redirect_to article_path(@article)
	  else
		  render 'edit'
	  end
  end

  def destroy
    # @article = Article.find(params[:id])
    # find_article
    return unless authorize_article

    @article.destroy
    flash[:alert] = "You delete article"
    redirect_to articles_path
  end

  private

  def authorize_article
    if current_user != @article.user && !current_user&.admin?
      flash[:alert] = "You are not allowed to be here"
      redirect_to articles_path
      return false
    end
    true
  end

  def article_params
    params.require(:article).permit(:title,:text, :tags)
  end

  def find_article
    @article = Article.find(params[:id])
  end

end