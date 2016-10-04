require 'rails_helper'

feature "User views recipes" do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:recipe2) { FactoryGirl.create(:recipe, title: "Another Recipe") }

  context "As a user" do
    scenario "when I go to the root path, I see a list of recipes" do
      visit "/"


      expect(page).to have_content(recipe.title)
      expect(page).to have_content(recipe2.title)
    end

    scenario "I can see a list of the recipes being reviewed" do

      visit recipes_path

      expect(page).to have_content(recipe.title)
      expect(page).to have_content(recipe2.title)
    end

    scenario "I can click on a recipe to see the recipe show page" do
      visit recipes_path
      click_link recipe.title

      expect(current_path).to eq(recipe_path(recipe))
      expect(page).to have_content(recipe.title)
      expect(page).to have_content(recipe.instructions)
      expect(page).to have_content(recipe.ingredients)
    end
  end
end
