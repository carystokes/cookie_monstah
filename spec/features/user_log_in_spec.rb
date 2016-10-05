# frozen_string_literal: true
require 'rails_helper'
require 'pry'

feature 'log in' do
  context 'as a user' do
    scenario 'user provides valid user information for log-in' do
      jon = FactoryGirl.create(:user)

      user_sign_in(jon)

      expect(page).to have_content('Signed in successfully.')
    end
  end
end
