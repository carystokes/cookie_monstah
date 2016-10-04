require 'rails_helper'

feature "User writes a review" do
  let!(:recipe) {FactoryGirl.create(:recipe)}
  context "As a user" do

    scenario "I can see reviews on the Recipe show page" do
      review = FactoryGirl.create(:review)
      visit recipe_path(recipe)

      expect(page).to have_content(review.rating)
      expect(page).to have_content(review.body)
    end

    scenario "There is a default message when no reviews have been left" do
      visit recipe_path(recipe)

      expect(page).to have_content "No one has reviewed this yet."
    end

    scenario "I can create a review on the Recipe show page" do
      visit recipe_path(recipe)
      fill_in "Rating" with 4
      fill_in "Body" with "I really like soup"

      expect(page).to have_content "Review created successfully"
      expect(page).to have_content "Rating: 4"
      expect(page).to have_content "I really like soup"
    end

    # scenario "I must be signed in to create a review" do
    # end

    scenario "I must a rating to create a review and optionally a description" do
      visit recipe_path(recipe)

    end

    scenario "I can provide only a rating and still create a review" do
      visit recipe_path(recipe)

    end

    scenario "I expect an error if I don't provide a rating" do
      visit recipe_path(recipe)

    end
  end
end
