class CommentsController < ApplicationController
  before_action :find_article

  def create
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

    @comment.user = current_user
    if @comment.save
      flash[:notice] = "You've successfuly add this comment"
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end

    def edit 
    	@comment = Comment.find(params[:id])
    end

    def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
          flash[:notice] = "You update comment"
          # redirect_to article_path(@article)
          redirect_to article_path(params[:id])
        else
          # render 'edit'
          redirect_to article_path(params[:id])
        end
    end

	def destroy
       @comment = Comment.find(params[:id])
       @comment.destroy
       flash[:alert] = "You delete comment"
       redirect_to article_path(@article)
	end

    private

    def find_article
    	@article = Article.friendly.find(params[:article_id]) 

	def comment_params
		params.require(:comment).permit(:body, :article_id)
	end		
end
end