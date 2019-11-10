require 'rails_helper'

feature 'User can sign out', '
  In order to end work
  As an authenticated user
  I\'d like to be able to sign out
' do
  background do
    user = create(:user)
    login_as(user)
    visit root_path
  end

  scenario 'User tries to sign out' do
    expect(page).to have_content 'Sign Out'
    click_on 'Sign Out'
    expect(page).to have_content 'Signed out successfully.'
  end
end
