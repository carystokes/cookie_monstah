# frozen_string_literal: true
require 'rails_helper'

feature 'admin views all users do' do
  let!(:review) { FactoryGirl.create(:review) }
  let!(:recipe) { review.recipe }
  let!(:user) { review.user }
  let!(:user2) { FactoryGirl.create(:user, first_name: 'Joan', admin: true) }
  context 'as an admin' do
    scenario 'an admin can delete recipes' do
      user_sign_in(user2)
      visit recipe_path(recipe)
      click_button 'Delete Recipe'

      expect(page).not_to have_content(recipe.title)
      expect(page).to have_content 'Recipe deleted'
    end

    scenario 'there is no link for an admin to edit recipes' do
      user_sign_in(user2)
      visit recipe_path(recipe)

      expect(page).not_to have_button 'Edit Recipe'
    end

    scenario 'an admin cannot edit recipes' do
      user_sign_in(user2)
      visit edit_recipe_path(recipe)

      expect(page).to have_content('You cannot edit this recipe')
    end

    scenario 'an admin can delete reviews' do
      user_sign_in(user2)
      visit recipe_path(recipe)
      click_button 'Delete Review'

      expect(page).to have_content 'Review successfully deleted'
    end

    scenario 'there is no link for an admin to edit reviews' do
      user_sign_in(user2)
      visit recipe_path(recipe)

      expect(page).not_to have_content 'Delete Review'
    end

    scenario 'an admin cannot edit reviews' do
      user_sign_in(user2)
      visit edit_review_path(review)

      expect(page).to have_content('You cannot edit this review')
    end
  end
end
