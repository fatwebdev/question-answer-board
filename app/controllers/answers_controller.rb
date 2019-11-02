class AnswersController < ApplicationController
  # expose :answers, from: :question
  expose :answer, build: ->(answer_params, _scope){ question.answers.new(answer_params) }

  def create
    if answer.save
      redirect_to answer
    else
      render :new
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

  def question
    Question.find(params[:question_id])
  end
end
