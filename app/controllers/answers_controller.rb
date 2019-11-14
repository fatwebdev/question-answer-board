# frozen_string_literal: true
class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]

  expose :question, -> { Question.find(params[:question_id]) }
  expose :answers, -> { question.answers.reject(&:new_record?) }
  expose :answer,
         build: ->(params, _scope) { question.answers.new(params.merge(user_id: current_user.id)) }

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
    if current_user.author_of?(answer)
      answer.destroy
      flash[:notice] = 'Answer delete successfully'
    else
      flash[:alert] = "You can not delete someone else's answer"
    end
    redirect_to answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
