require 'rails_helper'

feature 'User edits recipe' do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:user) { recipe.user }
  let!(:user2) { FactoryGirl.create(:user, first_name: "Fran",
      email: "frantheman@yahoo.com") }
  context 'As an authenicated user' do
    scenario 'I can navigate to an edit page of my own recipe' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_button 'Edit Recipe'

      expect(page).to have_content 'Edit Recipe'
    end

    scenario 'I can edit the title' do
      user_sign_in(user)
      visit edit_recipe_path(recipe)
      fill_in 'Title', with: 'This is the edited title'
      click_button 'Save Recipe'

      expect(page).to have_content 'Recipe edited successfully'
      expect(current_path).to eq(recipe_path(recipe))
      expect(page).to have_content 'This is the edited title'
      expect(page).not_to have_content 'Simple Recipe'
    end

    scenario 'I can edit the instructions' do
      user_sign_in(user)
      visit edit_recipe_path(recipe)
      fill_in 'Instructions', with: 'These are the edited instructions'
      click_button 'Save Recipe'

      expect(page).to have_content 'Recipe edited successfully'
      expect(current_path).to eq(recipe_path(recipe))
      expect(page).to have_content 'These are the edited instructions'
      expect(page).not_to have_content '1. combine the ingredients \
      2. eat soup'
    end

    scenario 'I can edit the ingredients' do
      user_sign_in(user)
      visit edit_recipe_path(recipe)
      fill_in 'Ingredients', with: 'These are the edited ingredients'
      click_button 'Save Recipe'

      expect(page).to have_content 'Recipe edited successfully'
      expect(current_path).to eq(recipe_path(recipe))
      expect(page).to have_content 'These are the edited ingredients'
      expect(page).not_to have_content 'garlic, carrots, soup'
    end

    scenario 'I can edit the description' do
      user_sign_in(user)
      visit edit_recipe_path(recipe)
      fill_in 'Description', with: 'This is the edited description'
      click_button 'Save Recipe'

      expect(page).to have_content 'Recipe edited successfully'
      expect(current_path).to eq(recipe_path(recipe))
      expect(page).to have_content 'This is the edited description'
      expect(page).not_to have_content 'Recipe for cookie soup'
    end

    scenario 'I get an error when I change the Title to nothing' do
      user_sign_in(user)
      visit edit_recipe_path(recipe)
      fill_in 'Title', with: ''
      click_button 'Save Recipe'

      expect(page).to have_content 'Title can\'t be blank'
    end

    scenario 'I get an error when I change the instructions to nothing' do
      user_sign_in(user)
      visit edit_recipe_path(recipe)
      fill_in 'Instructions', with: ''
      click_button 'Save Recipe'

      expect(page).to have_content 'Instructions can\'t be blank'
    end

    scenario 'I get an error when I change the ingredients to nothing' do
      user_sign_in(user)
      visit edit_recipe_path(recipe)
      fill_in 'Ingredients', with: ''
      click_button 'Save Recipe'

      expect(page).to have_content 'Ingredients can\'t be blank'
    end

    scenario 'There is no link to edit recipes made by other people' do
      user_sign_in(user2)
      visit recipe_path(recipe)

      expect(page).not_to have_link 'Edit Recipe'
    end

    scenario 'I cannot edit recipes made by other people' do
      user_sign_in(user2)
      visit edit_recipe_path(recipe)

      expect(page).to have_content('You cannot edit this recipe')
    end
  end
end
