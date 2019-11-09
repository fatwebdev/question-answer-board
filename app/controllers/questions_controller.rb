class QuestionsController < ApplicationController
  expose :questions, -> { Question.all }
  expose :question
  expose :answers, -> { question.answers }
  expose :answer, -> { question.answers.new }

  def create
    if question.save
      redirect_to question, notice: 'Question create successfully'
    else
      render :new
    end
  end

  def update
    if question.update(question_params)
      redirect_to question
    else
      render :edit
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
