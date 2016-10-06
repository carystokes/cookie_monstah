require 'rails_helper'

feature 'user page' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, first_name: 'Jenn', email: 'thejennster@frennz.com') }
  let!(:recipe) { FactoryGirl.create(:recipe) }
  scenario 'user is not logged in and goes to user page' do
    visit recipe_path(recipe)
    click_link 'Jenn Smith'

    expect(page).to have_content(user2.name)
    expect(page).to have_content(user2.recipes)
    expect(page).to have_content(user2.created_at)

    expect(page).not_to have_content('Edit')
    expect(page).not_to have_content('Delete')
  end

  scenario 'through the user page a user can visit a recipe' do
    visit user_path(user)
    click_link 'Cookie Soup'

    expect(page).to have_content('Cookie Soup')
    expect(page).to have_content(recipe.ingredients)
    expect(page).to have_content(recipe.instructions)
  end

  scenario 'a logged in user can edit their user information' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'

    expect(page).to have_content('Edit')
    click_button 'Edit'

    fill_in 'First name', with: 'Carl'
    click_button 'Submit'

    expect(page).to have_content('Carl Smith')
    expect(page).not_to have_content('Jon')

    click_button 'Change Picture'
    expect(page).to have_content('File to upload')
    fill_in 'File to upload', with:
     'https://upload.wikimedia.org/wikipedia/commons/b/b9/Chocolate_Chip_Cookies_-_kimberlykv.jpg'
    click_button 'upload'
    page.find('#profile_image')['src'].should have_content 'Chocolate_Chip_Cookies_-_kimberlykv.jpg' 
  end

  scenario 'a logged in user can delete their account :(' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Delete'

    expect(page).to have_content('Sorry to see you go!')
    expect(page).to have_content('Sign In')
  end
end
