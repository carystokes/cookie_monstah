require 'rails_helper'

feature 'User edits recipe' do
  let!(:user) {FactoryGirl.create(:user) }
  let!(:recipe) { FactoryGirl.create(:recipe, user: user) }
  context 'As an authenicated user' do
    scenario 'I can navigate to an edit page from the show page' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_link 'Edit Recipe'

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
  end
end
