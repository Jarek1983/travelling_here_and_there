class CommentsController < ApplicationController
  before_action :find_article

	def create
		  # binding.pry
		@comment = Comment.new(comment_params)
    # @comment.article = @article
		@article = @comment.article
    @comment.user = current_user
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

		if @comment.save
      # session[:commenter] = @comment.commenter
      flash[:notice] = "You create comment"
    #   redirect_to article_path(@article)
    # else
    #   render 'articles/show'
    # end
		  redirect_to article_path(session[:article_id])
      else
        redirect_to article_path(session[:article_id])
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
          redirect_to article_path(session[:article_id])
        else
          # render 'edit'
          redirect_to article_path(session[:article_id])
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
    	@article = Article.find(params[:article_id])

	def comment_params
		params.require(:comment).permit(:body, :article_id)
	end		
end
end
