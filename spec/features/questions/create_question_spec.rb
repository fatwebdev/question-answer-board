require 'rails_helper'

feature 'Create questions', '
  In order to be able to ask questions
  As an authenticate user
  I want to be able create question
' do
  given(:user) { create(:user) }

  background do
    login_as(user)
    visit root_path
  end

  scenario 'Create question' do
    click_on 'Ask question'
    fill_in 'Title', with: 'Test title'
    fill_in 'Body', with: 'Test text'
    click_on 'Create Question'

    expect(page).to have_content 'Question create successfully'
    expect(page).to have_content 'Test title'
    expect(page).to have_content 'Test text'
  end

  scenario 'Creating a question with errors' do
    click_on 'Ask question'
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_on 'Create Question'

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end
end

feature 'Can\'t create questions', '
  In order to be dont able to ask question
  As an unauthenticate user
  I want to be not able create question
' do
  background { visit root_path }

  scenario 'Can\'t click create question button' do
    expect(page).to_not have_selector(:link_or_button, 'Ask question')
  end

  scenario 'Can\'t visit create question path' do
    visit new_question_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
