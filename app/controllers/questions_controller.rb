class QuestionsController < ApplicationController
  before_action :authenticate_user, :only => [:create, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = current_user.questions.create(question_params)

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def update
    @question = current_user.questions.find(params[:id])

    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:title, :text)
  end
end
