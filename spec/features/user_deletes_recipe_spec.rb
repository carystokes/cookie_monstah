require 'rails_helper'

feature 'User deletes recipe' do
  let!(:user) {FactoryGirl.create(:user) }
  let!(:recipe) { FactoryGirl.create(:recipe, user: user) }
  context 'As an authenticated user' do
    scenario 'I can delete a recipe' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_link 'Delete Recipe'

      expect(page).not_to have_content(recipe.title)
      expect(page).to have_content 'Recipe deleted'
    end
  end
end
