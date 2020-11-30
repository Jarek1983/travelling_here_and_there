class LikesController < ApplicationController

  def create
    like = Like.new(article_id: Article.find_by(slug: params[:article_id]).id, user: current_user)
    like.save
    redirect_to article_path(params[:article_id])
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy     
    redirect_to article_path(like.article) 
  end
  
end
