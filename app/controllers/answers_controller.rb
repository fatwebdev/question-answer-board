class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  expose :question, -> { Question.find(params[:question_id]) }
  expose :answers, -> { question.answers }
  expose :answer, build: ->(params, _scope) { answers.new(params) }

  def create
    if answer.save
      redirect_to answer.question, notice: 'Answer create successfully'
    else
      render 'questions/show'
    end
  end

  def update
    if answer.update(answer_params)
      redirect_to answer
    else
      render :edit
    end
  end

  def destroy
    answer.destroy
    redirect_to answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
