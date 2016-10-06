# frozen_string_literal: true
require 'rails_helper'

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
      expect(page).to have_content('Welcome! You have signed up successfully.')
      save_and_open_page
      expect(page).to have_css('img#profile_image')
    end

    scenario 'user provides invalid information for registration' do
      visit new_user_registration_path
      click_button 'Sign Up'
      expect(page).to have_content('First name can\'t be blank')
    end

    scenario 'user already logged in' do
      jon = FactoryGirl.create(:user)

      user_sign_in(jon)
      visit new_user_registration_path
      expect(page).to have_content('You are already signed in.')
    end
  end
end
