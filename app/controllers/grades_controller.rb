class GradesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_grade, only: [:edit, :destroy]

  def new
    @grade = Grade.new
  end

  def edit
  	  
  end

  def create
    @grade = Grade.new(grade_params)
    @grade.comment_id = params[:comment_id] #trzeba się odwołać do id komentarza
    @grade.user = current_user
    # binding.pry
      if @grade.save
       redirect_to article_path(id: params[:article_id])
      else
       redirect_to article_path(id: params[:article_id])
      end
  end

  def destroy
    @grade = Grade.find(params[:id])

      if @grade.present?
        @grade.destroy
        redirect_to article_path(id: params[:article_id])
      end    
  end

   #  def voting
   #      @grade = Grade.find(params[:id])
   #  end

   #  def vote_minus
   #      @grade = Grade.find(params[:id])
   #      current_user.vote_minus(@grade)
   #  end

private

  def set_grade
    @grade = Grade.find(params[:id])
  end

  def find_comment
    @comment= Comment.find(params[:comment_id])
  end

  def find_article
    @article = Article.find(params[:article_id])
  end

  def grade_params
    params.require(:grade).permit(:number, :comment_id)
  end
  
end
