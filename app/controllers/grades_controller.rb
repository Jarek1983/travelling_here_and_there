class GradesController < ApplicationController

  before_action :authenticate_user!, only: [:create ,:edit, :update, :destroy, :vote_for]
  before_action :set_grade, only: [:show, :edit, :update, :destroy, :vote_for]

	def index
	  @grades = Grade.all.order("plusminus desc")  
	end

	def show
	  @comment = Comment.new(number: @grade) 
	end

	def new
	  @grade = Grade.new
	end

	def edit
	  
	end

	def create
	  @grade = Grade.new(grade_params)
	    if @grade.save
	    flash[:notice] = "You create grade"
	    else
	      render 'articles/show'
	    end
	end

    def update

      if @grade.update(grade_params)
        flash[:notice] = "Grade was successfully updated."
        redirect_to article_path(@article)
      else
        render 'edit'
      end
    end

    def destroy
       @grade = Grade.find(params[:id])
       @grade.destroy
       flash[:alert] = "You delete comment"
       redirect_to article_path(@article)
    end

  	def vote_plus
      @grade = Grade.find(params[:id])
      current_user.vote_plus(@grade)
      flash[:notice] = "update vote"
	  redirect_to article_path(@article)
    end

    def vote_minus
      @grade = Grade.find(params[:id])
      current_user.vote_minus(@grade)
      flash[:notice] = "update vote"
	  redirect_to article_path(@article)
    end

private

    def set_grade
       @grade = Grade.find(params[:id])
    end

    def grade_params
       params.require(:grade).permit(:number)
    end
end
