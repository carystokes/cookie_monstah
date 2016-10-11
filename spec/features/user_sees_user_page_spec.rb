require 'rails_helper'

feature 'user page' do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:user) { recipe.user }
  let!(:user2) { FactoryGirl.create(:user,
                  first_name: 'Jenn',
                  email: 'thejennster@frennz.com')
               }

  scenario 'user is not logged in and goes to user page via link' do
    visit recipe_path(recipe)
    click_link 'John Smith'
    expect(page).to have_content('John Smith')
    expect(page).to have_content('Simple')
    expect(page).not_to have_content('Edit')
    expect(page).not_to have_content('Delete')
  end

  scenario 'user is not logged in and goes to edit user page directly' do
    visit edit_user_path(user)
    expect(page).to have_content('You may only edit your own profile.')
  end

  scenario 'through the user page a user can visit a recipe' do
    visit user_path(user)
    click_link 'Simple Recipe'

    expect(page).to have_content('Simple Recipe')
    expect(page).to have_content(recipe.ingredients)
    expect(page).to have_content(recipe.instructions)
  end

  scenario 'a logged in user can edit their user information' do
    user_sign_in(user)
    visit user_path(user)

    expect(page).to have_content('Edit')
    click_link 'Edit'

    fill_in 'First name', with: 'Carl'
    click_button 'Save Changes'

    expect(page).to have_content('Carl Smith')
    expect(page).not_to have_content('Jon')

    click_link 'Edit'

    page.attach_file('Avatar', Rails.root +
      'spec/fixtures/Cookie-Monster-Cookies.jpg')
    click_button 'Save Changes'

    page.find('#profile_image')['src'].should have_content
      'Cookie-Monster-Cookies.jpg'
  end

  scenario 'a logged in user can delete their account :(' do
    user_sign_in(user)
    visit user_path(user)
    click_link 'Delete'

    expect(page).to have_content('User deleted')
    expect(page).to have_content('Log In')
  end
end
