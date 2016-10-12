# frozen_string_literal: true

require 'rails_helper'

feature 'user can edit reviews' do
  let!(:review) { FactoryGirl.create(:review) }
  let!(:user) { review.user }
  let!(:recipe) { review.recipe }
  let!(:user2) { FactoryGirl.create(:user, first_name: 'Fran') }
  context 'as a authenticated user' do
    scenario 'I can edit my own reviews' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_link 'Edit Review'
      fill_in 'Rating', with: 2
      fill_in 'Body', with: 'I\'m over cookie soup now'
      click_button 'Save Review'

      expect(page).to have_content('Review successfully edited')
      expect(page).to have_content('I\'m over cookie soup now')
      expect(page).not_to have_content('I LOVE COOKIE SOUP!!!')
    end

    scenario 'I cannot edit other people\'s reviews' do
      user_sign_in(user2)
      visit recipe_path(recipe)

      expect(page).not_to have_link('Edit Review')
    end

    scenario 'I cannot edit the rating to be an integer not between 1 and 5' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_link 'Edit Review'

      fill_in 'Rating', with: 27
      fill_in 'Body', with: 'THIS IS THE BEST COOKIE SOUP EVER!!!!!'

      click_button 'Save Review'

      expect(page).to have_content 'Rating must be between 1 - 5'
    end

    scenario 'I expect an error if I put a rating that is not an integer' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_link 'Edit Review'

      fill_in 'Rating', with: 3.7

      click_button 'Save Review'

      expect(page).to have_content 'Rating must be an integer'
    end

    scenario 'I expect an error if I remove the rating' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_link 'Edit Review'

      fill_in 'Rating', with: ""
      fill_in 'Body', with: 'I don\'t like numbers I\'d rather\
       just use my words.'

      click_button 'Save Review'

      expect(page).to have_content 'Rating is not a number'
    end
  end
end
