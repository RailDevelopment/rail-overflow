class AnswersController < ApplicationController
    before_action :authenticate_user, :only => [:create, :destroy]
    def create
        @question = Question.find(params[:question_id])
        @answer = @question.answers.create(answer_params)
        if @answer.save
            redirect_to question_path(@question)
        else
            flash[:error] = "Error saving answer."
            redirect_to question_path(@question)
        end
    end

    def destroy
        @answer = current_user.answers.find(params[:id])
        @question = @answer.question
        @answer.destroy
        redirect_to question_path(@question)
    end
     
    private
        def answer_params
            params.require(:answer).permit(:text).merge(
                :user_id => current_user.id
            )
        end
end
