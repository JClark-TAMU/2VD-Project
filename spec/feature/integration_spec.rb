# location: spec/feature/integration_spec.rb
require 'rails_helper'
require 'omniauth'

RSpec.describe('Going to the Officers page', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link 'Sign in with Google'
  end

  it 'reachable paths' do
    visit officer_path
    expect(page).to(have_content('Meet the officers in charge of 2VD.'))
    visit users_path
    expect(page).to(have_content('Users'))
    visit officer_path
    expect(page).to(have_content('Officers'))
  end

  it 'officer appears' do
    tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'True', role: 'Member', bio: 'I am a frog', portfolioID: '1')
    visit officer_path
    expect(page).to(have_content('I am a frog'))
  end

  it 'standard member does not appear' do
    tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: '', role: 'Member', bio: 'I am a frog', portfolioID: '1')
    visit officer_path
    expect(page).not_to(have_content('I am a frog'))
  end
end

RSpec.describe('Editing a user bio', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link 'Sign in with Google'
  end

  it 'valid inputs' do
    tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit edit_user_path(tempUser)
    fill_in 'user_bio', with: 'I like to draw'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('I like to draw'))
  end

  it 'invalid inputs' do
    tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit edit_user_path(tempUser)
    fill_in 'user_bio', with: ''
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('I am a frog'))
  end
end

RSpec.describe('Editing a user', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link 'Sign in with Google'
  end

  it 'valid input username' do
    tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Doggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('Doggers'))
  end

  it 'valid input role' do
    tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit edit_user_path(tempUser)
    fill_in 'user_role', with: 'Officer'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('Officer'))
  end
end

RSpec.describe('User Profile', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link 'Sign in with Google'
  end

  it 'valid inputs' do
    tempUser = User.create!(username: 'Froggers', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit user_path(tempUser)
    expect(page).to(have_content('Froggers'))
    expect(page).to(have_content('Member'))
    expect(page).to(have_content('I am a frog'))
  end
end

RSpec.describe 'User Portfolio', type: :feature do
  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link "Sign in with Google"
  end
  
  scenario 'creates portfolio on update for new users' do
    tempUser = User.create!(username: 'guest', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to have_content('untitled')
  end

  scenario 'does not show portfolio for guest' do
    tempUser = User.create!(username: 'guest', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit users_path
    expect(page).not_to(have_content('untitled'))
  end

  scenario 'title is updated when changed' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to have_content('untitled')
    click_on 'untitled'
    click_on 'Edit title'
    fill_in 'portfolio_title', with: 'Concept Art'
    click_on 'Update Portfolio'
    visit users_path
    expect(page).to have_content('Concept Art')
  end

  scenario 'can be edited by owner' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    click_on 'untitled'
    expect(page).to have_content('Edit title')
  end
end

# ALL TESTS SHOULD BE PLACED ABOVE THIS ONE
# Otherwise, they will not work
RSpec.describe('Logging In and Logging Out', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  it 'valid inputs' do
    visit root_path
    click_link 'Sign in with Google'
    expect(page).to(have_content('You\'re logged in!'))
    click_link 'Sign Out'
    expect(page).to(have_content("You\'re Logged out!"))
  end

  it 'invalid login' do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    visit root_path
    click_link 'Sign in with Google'
    expect(page).not_to(have_content('You\'re logged in!'))
  end
end
