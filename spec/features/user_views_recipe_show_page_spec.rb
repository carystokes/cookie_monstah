require 'rails_helper'

feature 'User views recipes on show page' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:recipe) { FactoryGirl.create(:recipe, user: user) }
  let!(:recipe2) { FactoryGirl.create(:recipe, description: nil, user: user) }

  context 'As a user' do
    scenario 'I can see the recipe title on the recipe show page' do
      visit recipe_path(recipe)

      expect(page).to have_content(recipe.title)
    end

    scenario 'I can see a description on the recipe show page' do
      visit recipe_path(recipe)

      expect(page).to have_content(recipe.description)
    end

    scenario 'I don\'t see a description on a recipe show page that doesn\'t have one' do
      visit recipe_path(recipe2)

      expect(page).not_to have_content(recipe.description)
    end

    scenario 'I can see a list of ingredients on the recipe show page' do
      visit recipe_path(recipe)

      expect(page).to have_content(recipe.ingredients)
    end

    scenario 'I can see a list of instructions on the recipe show page' do
      visit recipe_path(recipe)

      expect(page).to have_content(recipe.instructions)
    end
  end
end
