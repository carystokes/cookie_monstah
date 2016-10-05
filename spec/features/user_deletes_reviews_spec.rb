require 'rails_helper'

feature 'user can delete reviews' do
  let!(:review) { FactoryGirl.create(:review) }
  let!(:user2) { FactoryGirl.create(:user, first_name: "Fran",
      email: "frantheman@yahoo.com") }
  context 'as a authenticated user' do
    scenario 'I can delete my own reviews' do
      user_sign_in(review.user)
      visit_recipe_path(review.recipe)
      click_link 'Delete Review'

      expect(page).to have_content('Review successfully deleted')
      expect(page).not_to have_content('I LOVE COOKIE SOUP!!!')
    end

    scenario 'I cannot delete other people\'s reviews' do
      user_sign_in(user2)
      visit_recipe_path(review.recipe)

      expect(page).not_to have_link('Delete Review')
    end
  end
end
