# location: spec/feature/integration_spec.rb
require 'rails_helper'
require 'omniauth'

RSpec.describe 'Going to the Officers page', type: :feature do
  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link "Sign in with Google"
  end
  scenario 'reachable paths' do
    visit officer_path
    expect(page).to have_content('Meet the officers in charge of 2VD.')
    visit users_path
    expect(page).to have_content('Users')
    visit officer_path
    expect(page).to have_content('Officers')
  end
  scenario 'officer appears' do
    tempUser = User.create!(username: 'Froggers', password: '12345', email: 'gmail@gmail.com', isAdmin: 'True', role: 'Member', bio: 'I am a frog', portfolioID: '1')
    visit officer_path
    expect(page).to have_content('I am a frog')
  end
  scenario 'standard member does not appear' do
    tempUser = User.create!(username: 'Froggers', password: '12345', email: 'gmail@gmail.com', isAdmin: '', role: 'Member', bio: 'I am a frog', portfolioID: '1')
    visit officer_path
    expect(page).not_to have_content('I am a frog')
  end
end

RSpec.describe 'Editing a user bio', type: :feature do
    before(:each) do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      visit root_path
      click_link "Sign in with Google"
    end
    scenario 'valid inputs' do
      tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
      visit edit_user_path(tempUser)
      fill_in 'user_bio', with: 'I like to draw'
      click_on 'Update User'
      visit users_path
      expect(page).to have_content('I like to draw')
    end
    scenario 'invalid inputs' do
      tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
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
      tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
      visit edit_user_path(tempUser)
      fill_in 'user_username', with: 'Doggers'
      click_on 'Update User'
      visit users_path
      expect(page).to have_content('Doggers')
    end
    scenario 'valid input isAdmin' do
      tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
      visit edit_user_path(tempUser)
      check 'user_isAdmin'
      visit users_path
      expect(page).to have_content('true')
    end
    scenario 'valid input role' do
      tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
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
    tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit user_path(tempUser)
    expect(page).to have_content('Froggers')
    expect(page).to have_content('Member')
    expect(page).to have_content('I am a frog')
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