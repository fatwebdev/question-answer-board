require 'rails_helper'

feature 'User can sign in', '
  In order to ask question
  As an unauthenticated user
  I\'d like to be able to sign in
' do
  given!(:user) { create(:user) }

  background do
    visit root_path
    click_on 'Sign In'
  end

  context 'as registered user' do
    background do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end

    scenario 'tries to sign in' do
      expect(page).to have_content 'Signed in successfully'
    end

    scenario 'does not able to sign in if already sign in' do
      expect(page).to_not have_content 'Sign in'

      visit new_user_session_path
      expect(page).to have_content 'You are already signed in.'
    end
  end

  context 'as not registered user' do
    scenario 'does not able to sign in' do
      fill_in 'Email', with: 'wrong@test.com'
      fill_in 'Password', with: '12345678'
      click_on 'Log in'

      expect(page).to have_content 'Invalid Email or password'
    end
  end
end
