require 'rails_helper'

feature 'Delete question', '
  In order to be able delete question
  As it author
  I want to be able to delete question
' do
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }

  scenario 'delete a question' do
    login_as(author)
    visit question_path(question)

    click_on 'Delete Question'

    expect(page).to have_content 'Question delete successfully'
    expect(current_path).to eql questions_path
  end
end

feature 'Don\'t delete question', "
  In order to don't able other user interfere work
  As an authorized user
  I don't want to be able to delete other questions
" do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, user: author) }

  scenario "don't be able delete a question" do
    login_as(user)
    visit question_path(question)

    expect(page).to_not have_content 'Delete Question'
  end
end
