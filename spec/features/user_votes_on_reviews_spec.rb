# frozen_string_literal: true

require 'rails_helper'

feature 'User votes on reviews' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:review) { FactoryGirl.create(:review) }

  context 'As a user' do
    scenario 'I can upvote a review' do
      user_sign_in(user)
    end

    scenario 'I can downvote a review' do
    end

    scenario 'I can change my upvote to a downvote' do
    end

    scenario 'I can change my downvote to an upvote' do
    end

    scenario 'if I try to click up when I\'ve already upvoted, \
    nothing happens' do
    end

    scenario 'if I try to click down when I\'ve already downvoted,\
     nothing happens' do
    end
  end
end
