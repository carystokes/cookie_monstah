require 'rails_helper'

feature 'admin views all users do' do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:user) { recipe.user }
  let!(:user2) {FactoryGirl.create(:user, name: 'Joan', admin: true)}
  context 'as an admin' do
    feature 'an admin can delete recipes' do

    end

    feature 'there is no link for an admin to edit recipes' do

    end

    feature 'an admin cannot edit recipes' do
      
    end
  end
end
