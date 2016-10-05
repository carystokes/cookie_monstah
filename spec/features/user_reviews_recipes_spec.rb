require 'rails_helper'

feature 'User writes a review' do
  let!(:recipe) {FactoryGirl.create(:recipe)}
  # let!(:review) {FactoryGirl.create(:review)}
  context 'As a user' do

    scenario 'I can see reviews on the Recipe show page' do
      review = Review.create(
        rating: 3,
        body: 'soup is not a cookie but it was delicious',
        recipe: recipe
      )
      visit recipe_path(recipe)

      expect(page).to have_content(review.rating)
      expect(page).to have_content(review.body)
    end

    scenario 'There is a default message when no reviews have been left' do
      visit recipe_path(recipe)

      expect(page).to have_content 'No one has reviewed this yet.'
    end

    scenario 'I can create a review on the Recipe show page' do
      visit recipe_path(recipe)
      fill_in 'Rating', with: 4
      fill_in 'Body', with: 'I really like soup'

      click_button 'Add a Review'

      expect(page).to have_content 'Review created successfully'
      expect(page).to have_content 'Rating: 4'
      expect(page).to have_content 'I really like soup'
    end

    # scenario 'I must be signed in to create a review' do
    # end

    scenario 'I must have a rating to create a review and optionally a description' do
      visit recipe_path(recipe)

      fill_in 'Rating', with: 4

      click_button 'Add a Review'

      expect(page).to have_content 'Review created successfully'
      expect(page).to have_content 'Rating: 4'
    end

    scenario 'I expect an error if I put a rating that is not between 1 and 5' do
      visit recipe_path(recipe)

      fill_in 'Rating', with: 27
      fill_in 'Body', with: 'THIS IS THE BEST COOKIE SOUP EVER!!!!!'

      click_button 'Add a Review'

      expect(page).to have_content 'Rating must be between 1 - 5'
    end

    scenario 'I expect an error if I put a rating that is not an integer' do
      visit recipe_path(recipe)

      fill_in 'Rating', with: 3.7

      click_button 'Add a Review'

      expect(page).to have_content 'Rating must be an integer'
    end

    scenario 'I expect an error if I don\'t provide a rating' do
      visit recipe_path(recipe)

      fill_in 'Body', with: 'I don\'t like numbers I\'d rather just use my words.'

      click_button 'Add a Review'

      expect(page).to have_content 'Rating is not a number'
    end
  end
end