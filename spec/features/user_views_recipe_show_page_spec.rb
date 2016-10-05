require 'rails_helper'

feature 'User views recipes on show page' do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:recipe2) { FactoryGirl.create(:recipe, description: nil) }

  context 'As a user' do
    scenario 'I can see the recipe title on the recipe show page' do
      visit recipe_path(recipe)

      expect(page).to have_content(recipe.title)
    end

    # scenario 'I can see the creator of the recipe on the recipe show page' do
    #
    # end

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

    # scenario 'I can see reviews on the recipe show page' do
    #   visit recipe_path(recipe)
    # end
    #
    # scenario 'I can see who posted the review' do
    #   visit recipe_path(recipe)
    # end
    #
    # scenario 'I can see the rating that goes with the review' do
    #   visit recipe_path(recipe)
    # end
  end
end
