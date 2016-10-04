require 'rails_helper'
require 'pry'

feature 'log in' do
  context 'as a user' do
    scenario 'user provides valid user information for log-in' do
      visit new_user_registration_path
      fill_in 'First name', with: 'Jon'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign Up'
      click_link 'Log Off'
      expect(page).to have_content("Signed out successfully.")

      visit new_user_session_path
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      expect(page).to have_content("Signed in successfully.")

      click_link 'Log In'
      expect(page).to have_content('You are already signed in.')
    end
  end
end
