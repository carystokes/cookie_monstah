require 'rails_helper'
require 'pry'

feature 'sign up' do
  context 'as a user' do
    scenario 'user provides valid user information for registration' do
      visit new_user_registration_path
      fill_in 'First name', with: 'Jon'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign Up'
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    scenario 'user provides invalid information for registration' do
      visit new_user_registration_path
      click_button 'Sign Up'
      expect(page).to have_content("First name can't be blank")
    end

    scenario 'user already logged in' do
      visit new_user_registration_path
      fill_in 'First name', with: 'Jon'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign Up'      
    end
  end
end
