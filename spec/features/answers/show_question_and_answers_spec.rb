require 'rails_helper'

feature 'Show question and relative answers', '
  In order to be able show question and answer
  As a simple user
  I want to go to the question page
' do
  given(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 5, :dynamic, question: question) }

  scenario 'Show question with answers' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
