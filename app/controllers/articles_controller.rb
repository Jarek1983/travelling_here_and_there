class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy, :toggle_visibility]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_article, only: [:destroy, :edit, :update]
  
  def index
    if current_user&.admin?
        @articles = Article.all
    else
        @articles = Article.published
    end
  	# binding.pry
    @most_commented = @articles.most_commented
    @articles = @articles.includes(:user).order(id: :desc).page(params[:page]).per(5)
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
    @like = Like.find_or_initialize_by(article: @article, user: current_user)
    # @article = Article.find(params[:id])
    # find_article
    respond_to do |format|
      format.html do
        @article.increment!(:views_count)
        render
      end

      format.json do 
        sleep(rand((20.0)/10))
        render json: {
          id: @article.id,
          title: @article.title,
          text: @article.text,
          views_count: @article.views_count,
          likes_count: @article.likes.count,
          comments_count: @article.comments.count
        }
      end
    end
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

  def toggle_visibility
    return redirect_to articles_path, error: 'Not found' unless current_user&.admin?
    @article.toggle!(:published)
    redirect_to articles_path, notice: 'Your article\'s visibility has been changed'
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
    params.require(:article).permit(:title,:text, :tags, :image)
  end

  def find_article
     @article = if current_user&.admin?
                  Article.find(params[:id])
                else
                  Article.published.find(params[:id])
                end
  end

end