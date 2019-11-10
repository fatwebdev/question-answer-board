require 'rails_helper'

feature 'User can sign up', '
  In order to ask question
  As an unauthenticated user
  I\'d like to be able to sign up
' do
  background do
    visit root_path
    click_on 'Sign Up'
  end

  scenario 'User tries to sign in' do
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'User tries to sign in with registred email' do
    user = create(:user)

    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end
end
