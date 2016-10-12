# frozen_string_literal: true

require 'rails_helper'

feature 'User votes on reviews' do
  let!(:review) { FactoryGirl.create(:review) }
  let!(:user) { review.user }
  let!(:recipe) { review.recipe }
  let!(:user2) { FactoryGirl.create(:user, first_name: "Jane") }

  context 'As a user' do
    scenario 'I can see the upvotes and downvotes' do
      visit recipe_path(recipe)

      expect(page).to have_content '0'
    end

    scenario 'I cannot upvote a review if I\'m not signed in.' do
      visit recipe_path(recipe)
      click_button 'upvote'

      expect(page).to have_content 'Please sign in'
    end

    scenario 'I cannot downvote a review if I\'m not signed in.' do
      visit recipe_path(recipe)
      click_button 'downvote'

      expect(page).to have_content 'Please sign in'
    end

    scenario 'I can upvote a review' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_button'upvote'

      expect(review.votes[0].value).to eq 1
    end

    scenario 'I can downvote a review' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_button 'downvote'

      expect(review.votes[0].value).to eq -1
    end

    scenario 'I can change my upvote to a downvote' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_button 'upvote'
      click_button 'downvote'

      expect(review.votes[0].value).to eq -1
    end

    scenario 'I can change my downvote to an upvote' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_button 'downvote'
      click_button 'upvote'

      expect(review.votes[0].value).to eq 1
    end

    scenario 'if I try to click up when I\'ve already upvoted, \
    my upvote is deleted' do
      user_sign_in(user)
      visit recipe_path(recipe)
      click_button 'upvote'
      click_button 'upvote'

      expect(review.votes[0].value).to eq 0
    end

    scenario 'if I try to click down when I\'ve already downvoted,\
     my downvote is deleted' do
       user_sign_in(user)
       visit recipe_path(recipe)
       click_button 'downvote'
       click_button 'downvote'

       expect(review.votes[0].value).to eq 0
    end
  end
end
