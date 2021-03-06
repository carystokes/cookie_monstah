# frozen_string_literal: true
require 'rails_helper'

feature 'User writes a review' do
  let!(:user2) { FactoryGirl.create(:user, first_name: 'Fran') }
  let!(:recipe) { FactoryGirl.create(:recipe) }

  context 'As a user' do
    scenario 'I can see reviews on the Recipe show page' do
      review = Review.create(
        rating: 3,
        body: 'soup is not a cookie but it was delicious',
        recipe: recipe,
        user: recipe.user
      )
      visit recipe_path(recipe)

      expect(page).to have_content(review.rating)
      expect(page).to have_content(review.body)
    end

    scenario 'There is a default message when no reviews have been left' do
      user_sign_in(user2)
      visit recipe_path(recipe)

      expect(page).to have_content 'No one has reviewed this yet.'
    end

    scenario 'I can create a review on the Recipe show page' do
      user_sign_in(user2)
      visit recipe_path(recipe)
      fill_in 'Rating', with: 4
      fill_in 'Body', with: 'I really like soup'

      click_button 'Add a Review'

      expect(page).to have_content 'Review created successfully'
      expect(page).to have_content '4'
      expect(page).to have_content 'I really like soup'
    end

    scenario 'if I am not logged in, I cannot create a review' do
      visit recipe_path(recipe)
      fill_in 'Rating', with: 4
      fill_in 'Body', with: 'I really like soup'

      click_button 'Add a Review'

      expect(page).to have_content 'Please sign in'
    end

    scenario 'I must have a rating to create a review and optionally\
     a description' do
      user_sign_in(user2)
      visit recipe_path(recipe)

      fill_in 'Rating', with: 4

      click_button 'Add a Review'

      expect(page).to have_content 'Review created successfully'
      expect(page).to have_content '4'
    end

    scenario 'I expect an error if I put a rating that is not between\
     1 and 5' do
      user_sign_in(user2)
      visit recipe_path(recipe)

      fill_in 'Rating', with: 27
      fill_in 'Body', with: 'THIS IS THE BEST COOKIE SOUP EVER!!!!!'

      click_button 'Add a Review'

      expect(page).to have_content 'Rating must be between 1 - 5'
    end

    scenario 'I expect an error if I put a rating that is not an integer' do
      user_sign_in(user2)
      visit recipe_path(recipe)

      fill_in 'Rating', with: 3.7

      click_button 'Add a Review'

      expect(page).to have_content 'Rating must be an integer'
    end

    scenario 'I expect an error if I don\'t provide a rating' do
      user_sign_in(user2)
      visit recipe_path(recipe)

      fill_in 'Body', with: 'I don\'t like numbers I\'d rather\
       just use my words.'

      click_button 'Add a Review'

      expect(page).to have_content 'Rating is not a number'
    end

    scenario 'I expect to get an email when my product is reviewed' do
      ActionMailer::Base.deliveries = []
      user_sign_in(user2)
      visit recipe_path(recipe)

      fill_in 'Rating', with: 4

      click_button 'Add a Review'
      fill_in 'Body', with: 'I don\'t like numbers I\'d rather\
       just use my words.'

      expect(page).to have_content 'Review created successfully'
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.last).to have_subject(
        "New Review for #{recipe.title}"
      )
      expect(ActionMailer::Base.deliveries.last).to\
       deliver_to(recipe.user.email)
      expect(ActionMailer::Base.deliveries.last).to have_body_text(
        "Hello #{recipe.user.first_name}, #{user2.first_name} #{user2.last_name}
         has left a new review for your recipe #{recipe.title}. Check it out!"
      )
    end
  end
end
