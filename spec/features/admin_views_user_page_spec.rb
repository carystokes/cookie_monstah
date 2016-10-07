require 'rails_helper'

feature 'admin views user page do' do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:user2) {FactoryGirl.create(:user, name: 'Joan', admin: true)}
  context 'as an admin' do
    feature 'admin can delete a user\'s account' do
      user_sign_in(user2)
      visit user_path(user)
      click_link 'Delete'

      expect(page).to have_content('Account has been deleted')
      expect(page).not_to have_content('John Smith')
    end

    feature 'there is no edit account button for admins' do
      user_sign_in(user2)
      visit user_path(user)

      expect(page).not_to have_content('Edit')
    end

    feature 'admin cannot edit a user\'s account' do
      user_sign_in(user2)
      visit edit_user_path(user)

      expect(page).to have_content('You may only edit your own profile')
    end

    feature 'admin can turn other users into admins' do
      user_sign_in(user2)
      user_sign_in(user2)
      visit user_path(user)
      click_button 'Create Admin'

      expect(user.admin).to eq(true)
    end
  end
end
