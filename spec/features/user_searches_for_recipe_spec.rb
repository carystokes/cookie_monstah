require 'rails_helper'

feature 'search' do
  context 'as a user' do
    scenario 'user sees a search bar' do
      visit root_path

      expect(page).to have_content("Search")
    end

    scenario 'user searches for a recipe by name' do
      visit root_path

      fill_in 'Search', with: 'spiders'
      click_button 'Search'
      expect(page).to have_content('Spider Donuts')
      expect(page).to have_content('Creepy Cookies')
      expect(page).not_to have_content('Cookie Soup')
    end

    scenario 'user searches for a recipe that is not in the index' do
      visit root_path

      fill_in 'Search', with: 'rocks'
      click_button 'Search'
      expect(page).to have_content('No recipes found.')
      expect(page).not_to have_content('Cookie Soup')
    end
  end
end
