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

RSpec.describe('User Portfolio', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link 'Sign in with Google'
  end

  it 'creates portfolio on update for new users' do
    tempUser = User.create!(username: 'guest', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
  end

  it 'does not show portfolio for guest' do
    tempUser = User.create!(username: 'guest', email: 'britwiz@tamu.edu', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    visit users_path
    expect(page).not_to(have_content('untitled'))
  end

  it 'title is updated when changed' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    click_on 'untitled'
    click_on 'Edit title'
    fill_in 'portfolio_title', with: 'Concept Art'
    click_on 'Update Portfolio'
    visit users_path
    expect(page).to(have_content('Concept Art'))
  end

  it 'can be edited by owner' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    click_on 'untitled'
    expect(page).to(have_content('Edit title'))
  end
end

RSpec.describe('Images', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link 'Sign in with Google'
  end

  it 'image creation' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    click_on 'untitled'
    click_on 'New Image'
    fill_in 'image_title', with: 'Fjord'
    fill_in 'image_caption', with: 'Fjord'
    attach_file 'image_imageLink', 'spec/trolltunga-fjord.jpg'
    click_on 'Create Image'
    expect(page).to(have_content('Fjord'))
  end

  it 'image shows on portfolio' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    click_on 'untitled'
    click_on 'New Image'
    fill_in 'image_title', with: 'Fjord'
    fill_in 'image_caption', with: 'Fjord'
    attach_file 'image_imageLink', 'spec/trolltunga-fjord.jpg'
    click_on 'Create Image'
    all_images = page.all('img')
    all_images.each do |img|
      visit img[:src]
      page.status_code.should be 200
    end
  end

  it 'private image does not show on profile' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    click_on 'untitled'
    click_on 'New Image'
    fill_in 'image_title', with: 'Fjord'
    fill_in 'image_caption', with: 'Fjord'
    attach_file 'image_imageLink', 'spec/trolltunga-fjord.jpg'
    click_on 'Create Image'
    visit user_path(tempUser)
    all_images = page.all('img')
    all_images.each do |img|
      get img[:src]
      expect(response).not_to(be_successful)
    end
  end

  it 'images show up in index' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    click_on 'untitled'
    click_on 'New Image'
    fill_in 'image_title', with: 'Fjord'
    fill_in 'image_caption', with: 'Fjord'
    attach_file 'image_imageLink', 'spec/trolltunga-fjord.jpg'
    click_on 'Create Image'
    visit images_path
    expect(page).to(have_content('Fjord'))
  end
end

RSpec.describe('Galleries', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link 'Sign in with Google'
  end
  it 'is accessible' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit galleries_path
    expect(page).to(have_content('Galleries'))
  end
  it 'shows galleries' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    tempgallery = Gallery.create!(prompt: "Artwork")
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit galleries_path
    expect(page).to(have_content('Artwork'))
  end
  it 'galleries are clickable' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    tempgallery = Gallery.create!(prompt: "Artwork")
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit galleries_path
    expect(page).to(have_content('Artwork'))
    click_on 'Show'
    expect(page).to(have_content('Artwork'))
  end
  it 'galleries cannot be changed by standard users' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    tempgallery = Gallery.create!(prompt: "Artwork")
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit galleries_path
    expect(page).to(have_content('Artwork'))
    expect(page).not_to(have_content('Edit'))
    expect(page).not_to(have_content('Destroy'))
  end
  it 'galleries can be changed by officers' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    tempUser.update(isAdmin: true)
    tempgallery = Gallery.create!(prompt: "Artwork")
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit galleries_path
    expect(page).to(have_content('Artwork'))
    expect(page).to(have_content('Edit'))
    click_on 'Edit'
    fill_in 'gallery_prompt', with: 'Panels'
    click_on 'Update Gallery'
    expect(page).to(have_content('Panels'))
    expect(page).not_to(have_content('Artwork'))
  end
  it 'galleries can be deleted by officers' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    tempUser.update(isAdmin: true)
    tempgallery = Gallery.create!(prompt: "Artwork")
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit galleries_path
    expect(page).to(have_content('Artwork'))
    expect(page).to(have_content('Destroy'))
    click_on 'Destroy'
    expect(page).not_to(have_content('Artwork'))
  end
  it 'galleries cannot be created by standard users' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    tempgallery = Gallery.create!(prompt: "Artwork")
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit galleries_path
    expect(page).not_to(have_content('New Gallery'))
  end
  it 'galleries can be created by officiers' do
    tempUser = User.find_by(email: 'britwiz@tamu.edu')
    tempUser.update(isAdmin: true)
    tempgallery = Gallery.create!(prompt: "Artwork")
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit galleries_path
    expect(page).to(have_content('New Gallery'))
    click_on 'New Gallery'
    fill_in 'gallery_prompt', with: 'Panels'
    click_on 'Create Gallery'
    expect(page).to(have_content('Panels'))
  end
end

RSpec.describe('Albums', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_link 'Sign in with Google'
  end
  it 'albums can be changed by officers' do
    currentUser = User.find_by(email: 'britwiz@tamu.edu')
    currentUser.update(isAdmin: true)
    tempUser = User.create!(username: 'otheruser', email: 'britwiz@gmail.com', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    tempPort = Portfolio.create!(title: 'untitled', user_id: tempUser.id)
    tempAlbum = Album.create!(name: 'panels', caption: 'panels I drew', user_id: tempUser.id, portfolio_id: tempPort.id)
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit albums_path
    expect(page).to(have_content('panels'))
    expect(page).to(have_content('Edit'))
    click_on 'Edit'
    fill_in 'album_name', with: 'cool images'
    fill_in 'album_caption', with: 'cool images'
    click_on 'Update Album'
    expect(page).to(have_content('cool images'))
    expect(page).not_to(have_content('panels'))
  end
  it 'albums can be deleted by officers' do
    currentUser = User.find_by(email: 'britwiz@tamu.edu')
    currentUser.update(isAdmin: true)
    tempUser = User.create!(username: 'otheruser', email: 'britwiz@gmail.com', isAdmin: 'False', role: 'Member', bio: 'I am a frog')
    tempPort = Portfolio.create!(title: 'untitled', user_id: tempUser.id)
    tempAlbum = Album.create!(name: 'panels', caption: 'panels I drew', user_id: tempUser.id, portfolio_id: tempPort.id)
    visit edit_user_path(tempUser)
    fill_in 'user_username', with: 'Froggers'
    click_on 'Update User'
    visit users_path
    expect(page).to(have_content('untitled'))
    visit albums_path
    expect(page).to(have_content('panels'))
    expect(page).to(have_content('Destroy'))
    click_on 'Destroy'
    expect(page).not_to(have_content('panels'))
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
