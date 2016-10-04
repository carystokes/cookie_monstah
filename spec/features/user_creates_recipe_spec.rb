require 'rails_helper'

feature "User creates recipe" do
  let!(:user_id) { 5 }
  context "As a user" do
    scenario "I can navigate to a page to create a new recipe" do
      visit root_path

      #test to make sure user is signed in?

      click_link "Add a Recipe"

      expect(current_path).to eq(new_recipe_path)
    end

    # scenario "I must be signed in to create a new recipe" do
    # end

    scenario "I must provide a title, ingredients, and instructions to create the recipe" do
      visit new_recipe_path
      fill_in "Title", with: "Title"
      fill_in "Ingredients", with: "These are the ingredients"
      fill_in "Instructions", with: "These are the instructions"
      fill_in "Description", with: "This is the description"
      click_button "Save Recipe"

      expect(page).to have_content "Recipe added successfully"
      expect(page).to have_content "Title"
      expect(page).to have_content "These are the ingredients"
      expect(page).to have_content "These are the instructions"

    end

    scenario "I expect an error if I don't provide a title" do
      visit new_recipe_path
      fill_in "Ingredients", with: "These are the ingredients"
      fill_in "Instructions", with: "These are the instructions"
      click_button "Save Recipe"

      expect(page).to have_content("Title can't be blank")

    end

    scenario "I expect an error if I don't provide ingredients" do
      visit new_recipe_path
      fill_in "Title", with: "Title"
      fill_in "Instructions", with: "These are the instructions"
      click_button "Save Recipe"

      expect(page).to have_content("Ingredients can't be blank")
    end

    scenario "I expect an error if I don't provide instructions" do
      visit new_recipe_path
      fill_in "Title", with: "Title"
      fill_in "Ingredients", with: "These are the ingredients"
      fill_in "Description", with: "This is the description"
      click_button "Save Recipe"

      expect(page).to have_content("Instructions can't be blank")
    end

    scenario "I don't get an error message if I don't provide a description" do
      visit new_recipe_path
      fill_in "Title", with: "Title"
      fill_in "Ingredients", with: "These are the ingredients"
      fill_in "Instructions", with: "These are the instructions"
      click_button "Save Recipe"

      expect(page).not_to have_content("Description can't be blank")
      expect(page).to have_content("Recipe added successfully")
    end

    # scenario "I can optionally check category boxes that align with allergens" do
    #   visit new_recipe_path
    #
    # end
  end
end
