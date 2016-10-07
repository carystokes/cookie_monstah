# require 'rails_helper'
#
# feature 'admin views all users do' do
#   let!(:recipe) { FactoryGirl.create(:recipe) }
#   let!(:user) { recipe.user }
#   let!(:user2) { FactoryGirl.create(:user, first_name: 'Joan', admin: true) }
#   context 'as an admin' do
#     scenario 'an admin can delete recipes' do
#       user_sign_in(user2)
#       visit recipe_path(recipe)
#       click_link 'Delete Recipe'
#
#       expect(page).not_to have_content(recipe.title)
#       expect(page).to have_content 'Recipe deleted'
#     end
#
#     scenario 'there is no link for an admin to edit recipes' do
#       user_sign_in(user2)
#       visit recipe_path(recipe)
#
#       expect(page).not_to have_link 'Edit Recipe'
#     end
#
#     scenario 'an admin cannot edit recipes' do
#       user_sign_in(user2)
#       visit edit_recipe_path(recipe)
#
#       expect(page).to have_content('You cannot edit this recipe')
#     end
#   end
# end
