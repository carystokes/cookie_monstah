require 'rails_helper'

feature 'User deletes recipe' do
  let!(:user2) { FactoryGirl.create(:user, first_name: "Fran",
      email: "frantheman@yahoo.com") }
  let!(:recipe) { FactoryGirl.create(:recipe) }
  context 'As an authenticated user' do
    scenario 'I can delete a recipe made by me' do
      user_sign_in(recipe.user)
      visit recipe_path(recipe)
      click_link 'Delete Recipe'

      expect(page).not_to have_content(recipe.title)
      expect(page).to have_content 'Recipe deleted'
    end

    # scenario 'I cannot delete recipes made by other people' do
    #   user_sign_in(user2)
    #   visit recipe_path(recipe)
    #
    #   expect(page).not_to have_link 'Delete Recipe'
    # end
  end
end
