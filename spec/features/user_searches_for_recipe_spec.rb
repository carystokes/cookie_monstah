require 'rails_helper'

feature 'search' do
  let!(:recipe) { FactoryGirl.create(:recipe) }
  let!(:recipe2) { FactoryGirl.create(:recipe, title: 'Spider Donuts') }
  let!(:recipe3) { FactoryGirl.create(:recipe, title: 'Creepy Cookies', ingredients: 'Some spiders, and some cookies') }

  context 'as a user' do
    scenario 'user sees a search bar' do
      visit root_path
      expect(page).to have_selector(:link_or_button, 'Search')
    end

    scenario 'user searches for a recipe by name' do
      visit root_path

      fill_in 'search', with: 'spider'
      click_button 'Search'
      expect(page).to have_content('Check out your search matches below!')
      expect(page).to have_content('Spider Donuts')
      expect(page).to have_content('Creepy Cookies')
      expect(page).not_to have_content('Simple Recipe')
    end

    scenario 'user searches for a recipe that is not in the index' do
      visit root_path

      fill_in 'search', with: 'rocks'
      click_button 'Search'
      expect(page).to have_content('Sorry, there were no matches.')
      expect(page).not_to have_content('Simple Recipe')
    end

    scenario 'user must fill in a search phrase' do
      visit root_path
      click_button 'Search'

      expect(page).to have_content('Please specify a search phrase')
    end
  end
end
