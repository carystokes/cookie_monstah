require 'rails_helper'

feature 'user can edit reviews' do
  let!(:review) { FactoryGirl.create(:review) }
  let!(:user2) { FactoryGirl.create(:user, first_name: "Fran",
      email: "frantheman@yahoo.com") }
  context 'as a authenticated user' do
    scenario 'I can edit my own reviews' do
      user_sign_in(review.user)
      visit_recipe_path(review.recipe)
      click_link 'Edit Review'
      fill_in 'Rating', with: 2
      fill_in 'Body', with: 'I\'m over cookie soup now'
      click_button 'Save Review'

      expect(page).to have_content('Review successfully edited')
      expect(page).to have_content('I\'m over cookie soup now')
      expect(page).not_to have_content('I LOVE COOKIE SOUP!!!')
    end

    scenario 'I cannot edit other people\'s reviews' do
      user_sign_in(user2)
      visit_recipe_path(review.recipe)

      expect(page).not_to have_link('Edit Review')
    end
  end
end
