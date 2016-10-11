require 'rails_helper'

feature 'admin views user page do' do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:user) { recipe.user }
  let!(:user2) { FactoryGirl.create(:user, first_name: 'Joan', admin: true) }
  context 'as an admin' do
    scenario 'admin can delete a user\'s account' do
      user_sign_in(user2)
      visit user_path(user)
      click_link 'Delete'

      expect(page).to have_content('User deleted')
      expect(page).not_to have_content('John Smith')
    end

    scenario 'there is no edit account button for admins' do
      user_sign_in(user2)
      visit user_path(user)

      expect(page).not_to have_content('Edit')
    end

    scenario 'admin cannot edit a user\'s account' do
      user_sign_in(user2)
      visit edit_user_path(user)

      expect(page).to have_content('You may only edit your own profile')
    end

    scenario 'admin can turn other users into admins' do
      user_sign_in(user2)
      visit user_path(user)
      click_button 'Create Admin'

      expect(user.admin).to be(true)
    end
  end
end
