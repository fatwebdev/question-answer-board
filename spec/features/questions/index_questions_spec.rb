require 'rails_helper'

feature 'Show all questions', '
  In order to be able show all questions
  As a simple user
  I want to go to the page with questions
' do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 5, user: user) }

  scenario 'Index questions' do
    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end
