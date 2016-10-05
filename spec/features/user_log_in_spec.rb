# frozen_string_literal: true
require 'rails_helper'
require 'pry'

feature 'log in' do
  context 'as a user' do
    scenario 'user provides valid user information for log-in' do
      jon = FactoryGirl.create(:user)

      visit new_user_session_path
      fill_in 'Email', with: jon.email
      fill_in 'Password', with: 'password'

      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
  end
end
