# frozen_string_literal: true
require 'rails_helper'

feature 'admin views all users do' do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:user) { recipe.user }
  let!(:user2) { FactoryGirl.create(:user, first_name: 'Joan', admin: true) }
  context 'as an admin' do
    scenario 'there is a page with all users listed' do
      user_sign_in(user2)
      visit users_path

      expect(page).to have_content('John Smith')
      expect(page).to have_content('Joan Smith')
    end

    scenario 'user names link to user pages' do
      user_sign_in(user2)
      visit users_path
      click_link 'John Smith'

      expect(page).to have_content('John Smith')
      expect(page).to have_content('Simple Recipe')
    end

    scenario 'there is a link to view all users in the header' do
      user_sign_in(user2)
      visit root_path
      click_link 'View All Users'

      expect(page).to have_content('John Smith')
      expect(page).to have_content('Joan Smith')
    end
  end

  context 'as a non-admin user' do
    scenario 'there is no link to view all users' do
      user_sign_in(user)
      visit root_path

      expect(page).not_to have_link('View All Users')
    end

    scenario 'navigating directly to the all users page doesn\'t work' do
      user_sign_in(user)
      visit users_path

      expect(page).to have_content('You are not authorized to view this page.')
    end
  end
end
