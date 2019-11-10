require 'rails_helper'

feature 'Create answer', '
  In order to be able get answer
  As a simple user
  I want to be able to create answer
' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    login_as(user)
    visit question_path(question)
  end

  scenario 'Create an answer' do
    fill_in 'Body', with: 'Test answer'
    click_on 'Create Answer'

    expect(page).to have_content 'Answer create successfully'
    expect(page).to have_content 'Test answer'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'Create an answer with errors' do
    fill_in 'Body', with: ''
    click_on 'Create Answer'

    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end
end

feature 'Can\'t create answer', '
  In order to be dont able to give answer
  As an unauthenticate user
  I want to be not able create answer
' do
  given(:question) { create(:question) }

  background { visit question_path(question) }

  scenario 'Can\'t click create answer button' do
    expect(page).to_not have_selector(:link_or_button, 'Create Answer')
  end
end
