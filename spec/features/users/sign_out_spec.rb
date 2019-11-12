require 'rails_helper'

feature 'User can sign out', '
  In order to end work
  As an authenticated user
  I\'d like to be able to sign out
' do
  given(:user) { create(:user) }

  context 'as authorized user' do
    scenario 'tries to sign out' do
      login_as(user)
      visit root_path

      expect(page).to have_content 'Sign Out'
      click_on 'Sign Out'
      expect(page).to have_content 'Signed out successfully.'
    end
  end

  context 'as not authorized user' do
    scenario 'does not able to sign out' do
      visit root_path

      expect(page).to_not have_content 'Sign Out'
    end
  end
end
