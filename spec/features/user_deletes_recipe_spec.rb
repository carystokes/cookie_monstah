require 'rails_helper'

feature 'User deletes recipe' do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  context 'As a user' do
    scenario 'I can delete a recipe' do
      visit recipe_path(recipe)
      click_link 'Delete Recipe'

      expect(page).not_to have_content(recipe.title)
      expect(page).to have_content 'Recipe deleted'
    end
  end
end
