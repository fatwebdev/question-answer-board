require 'rails_helper'

feature 'Create answer', '
  In order to be able get answer
  As a simple user
  I want to be able to create answer
' do
  given(:question) { create(:question) }

  background do
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
