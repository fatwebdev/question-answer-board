require 'rails_helper'

feature 'Create questions', '
  In order to be able to ask questions
  As a user
  I want to be able create question
' do
  background { visit questions_path }

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
