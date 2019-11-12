require 'rails_helper'

feature 'Delete answer', '
  In order to be able delete answer
  As it author
  I want to be able to delete answer
' do
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, user: author, question: question) }

  scenario 'delete a answer' do
    login_as(author)
    visit question_path(question)

    expect(page).to have_content answer.body

    click_on 'Delete Answer'

    expect(page).to have_content 'Answer delete successfully'
    expect(page).to_not have_content answer.body
    expect(current_path).to eql question_path(question)
  end
end

feature 'Don\'t delete answer', "
  In order to don't able other user interfere work
  As an authorized user
  I don't want to be able to delete other answers
" do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author)}

  scenario "don't be able delete a answer" do
    login_as(user)
    visit question_path(question)

    expect(page).to_not have_selector(:link_or_button, 'Delete Answer')
  end
end
