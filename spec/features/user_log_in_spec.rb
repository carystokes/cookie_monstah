# frozen_string_literal: true
require 'rails_helper'

feature 'log in' do
  let!(:jon) { FactoryGirl.create(:user) }
  context 'as a user' do
    scenario 'user provides valid user information for log-in' do
      user_sign_in(jon)

      expect(page).to have_content('Signed in successfully.')
    end

    scenario 'user can log off' do
      user_sign_in(jon)
      visit root_path
      click_link 'Log Off'

      expect(page).to have_content 'Signed out successfully'
    end
  end
end
