# location: spec/feature/integration_spec.rb
require 'rails_helper'
require 'omniauth'

RSpec.describe 'Editing a user bio', type: :feature do
    before(:each) do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      visit root_path
      click_link "Sign in with Google"
    end
    scenario 'valid inputs' do
      tempUser = User.create!(username: 'Froggers', email: 'gmail@gmail.com', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
      visit edit_user_path(tempUser)
      fill_in 'user_bio', with: 'I like to draw'
      click_on 'Update User'
      visit users_path
      expect(page).to have_content('I like to draw')
    end
    scenario 'invalid inputs' do
      tempUser = User.create!(username: 'Froggers', email: 'gmail@gmail.com', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
      visit edit_user_path(tempUser)
      fill_in 'user_bio', with: ''
      click_on 'Update User'
      visit users_path
      expect(page).to have_content('I am a frog')
    end
end

RSpec.describe 'Editing a user', type: :feature do
    before(:each) do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      visit root_path
      click_link "Sign in with Google"
    end
    scenario 'valid input username' do
      tempUser = User.create!(username: 'Froggers', email: 'gmail@gmail.com', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
      visit edit_user_path(tempUser)
      fill_in 'user_username', with: 'Doggers'
      click_on 'Update User'
      visit users_path
      expect(page).to have_content('Doggers')
    end
    scenario 'valid input email' do
      tempUser = User.create!(username: 'Froggers', email: 'gmail@gmail.com', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
      visit edit_user_path(tempUser)
      fill_in 'user_email', with: 'dog@dog.com'
      click_on 'Update User'
      visit users_path
      expect(page).to have_content('dog@dog.com')
    end
    scenario 'valid input isAdmin' do
      tempUser = User.create!(username: 'Froggers', email: 'gmail@gmail.com', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
      visit edit_user_path(tempUser)
      check 'user_isAdmin'
      visit users_path
      expect(page).to have_content('true')
    end
    scenario 'valid input role' do
      tempUser = User.create!(username: 'Froggers', email: 'gmail@gmail.com', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
      visit edit_user_path(tempUser)
      fill_in 'user_role', with: 'Officer'
      click_on 'Update User'
      visit users_path
      expect(page).to have_content('Officer')
    end
end

RSpec.describe 'User Profile', type: :feature do
  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link "Sign in with Google"
  end
  scenario 'valid inputs' do
    tempUser = User.create!(username: 'Froggers', email: 'gmail@gmail.com', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit user_path(tempUser)
    expect(page).to have_content('Froggers')
    expect(page).to have_content('Member')
    expect(page).to have_content('I am a frog')
  end
end

RSpec.describe 'Creating a user with valid attributes', type: :feature do
    before(:each) do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      visit root_path
      click_link "Sign in with Google"
    end
    scenario 'valid inputs' do
      visit new_user_path
      fill_in 'user_username', with: 'harry potter'
      fill_in 'user_email', with: 'britwiz@tamu.edu'
      fill_in 'user_bio', with: 'I am a wizard'
      fill_in 'user_role', with: 'wizard'
      click_on 'Create User'
      visit users_path
      expect(page).to have_content('wizard')
    end
    scenario 'invalid name' do
      visit new_user_path
      fill_in 'user_username', with: ''
      fill_in 'user_email', with: 'britwiz@tamu.edu'
      fill_in 'user_bio', with: 'I am a wizard'
      fill_in 'user_role', with: 'wizard'
      click_on 'Create User'
      visit users_path
      expect(page).not_to have_content('britwiz@tamu.edu')
      expect(page).not_to have_content('wizard')
    end
    scenario 'invalid email' do
      visit new_user_path
      fill_in 'user_username', with: 'harry potter'
      fill_in 'user_email', with: ''
      fill_in 'user_bio', with: 'I am a wizard'
      fill_in 'user_role', with: 'wizard'
      click_on 'Create User'
      visit users_path
      expect(page).not_to have_content('harry potter')
      expect(page).not_to have_content('wizard')
    end
    scenario 'invalid bio' do
      visit new_user_path
      fill_in 'user_username', with: 'harry potter'
      fill_in 'user_email', with: 'britwiz@tamu.edu'
      fill_in 'user_bio', with: ''
      fill_in 'user_role', with: 'wizard'
      click_on 'Create User'
      visit users_path
      expect(page).not_to have_content('harry potter')
      expect(page).not_to have_content('wizard')
    end
    scenario 'invalid role' do
      visit new_user_path
      fill_in 'user_username', with: 'harry potter'
      fill_in 'user_email', with: 'britwiz@tamu.edu'
      fill_in 'user_bio', with: 'I am a wizard'
      fill_in 'user_role', with: ''
      click_on 'Create User'
      visit users_path
      expect(page).not_to have_content('harry potter')
      expect(page).not_to have_content('britwiz@tamu.edu')
    end
    scenario 'incorrect email' do
      visit new_user_path
      fill_in 'user_username', with: 'harry potter'
      fill_in 'user_email', with: 'britwiz@hogwarts.edu'
      fill_in 'user_bio', with: 'I am a wizard'
      fill_in 'user_role', with: 'wizard'
      click_on 'Create User'
      expect(page).not_to have_content('harry potter')
      expect(page).not_to have_content('britwiz@tamu.edu')
      expect(page).to have_content('Wrong email address.')
    end
  end
#ALL TESTS SHOULD BE PLACED ABOVE THIS ONE
#Otherwise, they will not work
RSpec.describe 'Logging In and Logging Out', type: :feature do
    before(:each) do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end
    scenario 'valid inputs' do
      visit root_path
      click_link "Sign in with Google"
      expect(page).to have_content('You\'re logged in!')
      click_link "Sign Out"
      expect(page).to have_content("You\'re Logged out!")
    end
    scenario 'invalid login' do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
      visit root_path
      click_link "Sign in with Google"
      expect(page).not_to have_content('You\'re logged in!')
    end
end