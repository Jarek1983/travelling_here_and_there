class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy, :toggle_visibility]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :admin_authorize, except: [:index, :show]
  
  def index
    if current_user&.admin?
        @articles = Article.all
    else
        @articles = Article.published
    end

    @most_commented = @articles.most_commented
    @articles = @articles.includes(:user).order(id: :desc).page(params[:page]).per(9)
    @articles = @articles.where("? = any(tags)", params[:q]) if params[:q].present?
 
  end

  def new
    @article = Article.new
  end

  def create

    @article = Article.new(article_params)
    @article.user = current_user

      if @article.save
        flash[:notice] = "Utworzyłeś artykuł"
        redirect_to article_path(@article)
      else
        render 'new'
      end

  end

  def show
    @articles = Article.find_by_id(session[:article_id])
    @comment = Comment.new
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

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
    session[:article_id] = @article.id
  end

  def update

    if  
      @article.update(article_params)
      flash[:notice] = "Zaktualizowałeś artykuł"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end

  def destroy

    @article.destroy
    flash[:alert] = "Usunąłeś artykuł"
    redirect_to articles_path
  end

  def toggle_visibility
    return redirect_to articles_path, error: 'Not found' unless current_user&.admin?
    @article.toggle!(:published)
    redirect_to articles_path, notice: 'Your article\'s visibility has been changed'
  end

  private

    def admin_authorize
    redirect_to new_user_session_path, 
    alert: "Only for Admin!" unless current_user.admin
  end 
  
  def article_params
    params.require(:article).permit(:title,:text, :tags, :image, :image_second, :image_third, :image_fourth, :image_fifth, :image_sixth)
  end

  def find_article

    @article = if current_user&.admin?
                  Article.friendly.find(params[:id])
                else
                  Article.published.friendly.find(params[:id])
                end
  end

end