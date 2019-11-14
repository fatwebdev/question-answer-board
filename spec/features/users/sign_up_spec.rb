require 'rails_helper'

feature 'User can sign up', '
  In order to ask question
  As an unauthenticated user
  I\'d like to be able to sign up
' do
  given!(:user) { create(:user) }

  context 'as not authorized user' do
    background do
      visit root_path
      click_on 'Sign Up'
    end

    scenario 'User tries to sign up' do
      fill_in 'Email', with: 'user@test.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    scenario 'User tries to sign up with registred email' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'

      expect(page).to have_content 'Email has already been taken'
    end
  end

  context 'as authorized user' do
    background do
      login_as(user)
      visit root_path
    end

    scenario 'does not able to sign up' do
      expect(page).to_not have_selector(:link_or_button, 'Sign Up')
      visit new_user_registration_path
      expect(page).to have_content 'You are already signed in.'
    end
  end
end
