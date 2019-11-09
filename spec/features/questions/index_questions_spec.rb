require 'rails_helper'

feature 'Show all questions', '
  In order to be able show all questions
  As a simple user
  I want to go to the page with questions
' do
  scenario 'Index questions' do
    questions = create_list(:question, 5, :dynamic)

    visit questions_path

    questions.each do |q|
      expect(page).to have_content q.title
    end
  end
end
