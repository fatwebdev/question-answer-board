class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]

  expose :questions, -> { Question.all }
  expose :question,
         build: ->(params, _scope) { current_user.questions.new(params) }
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
    if current_user.author_of?(question)
      question.destroy
      flash[:notice] = 'Question delete successfully'
    else
      flash[:alert] = "You can not delete someone else's question"
    end
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
