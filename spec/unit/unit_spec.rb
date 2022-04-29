# location: spec/unit/unit_spec.rb
require 'rails_helper'

# User unit tests
RSpec.describe(User, type: :model) do
  subject do
    described_class.new(username: 'ben', email: 'ben@tamu.edu',
                        isAdmin: 'True', role: 'Officer', bio: 'I\'m Ben'
    )
  end

  # Sunny Day Cases
  it 'role is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'isAdmin is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  # Rainy Day Cases
  it 'role is not valid without a name' do
    subject.role = nil
    expect(subject).not_to(be_valid)
  end
end

RSpec.describe(User, type: :model) do
  subject do
    described_class.new(username: 'Froggers', email: 'gmail@gmail.com',
                        isAdmin: 'False', role: 'Member', bio: 'I like to draw'
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'is not valid without a name' do
    subject.bio = nil
    expect(subject).not_to(be_valid)
  end
end

# Portfolio unit tests
RSpec.describe(Portfolio, type: :model) do
  subject do
    described_class.new(title: 'Concept Art', user_id: portfolioOwner.id)
  end

  let(:portfolioOwner) do
    User.create(username: 'ben', email: 'ben@tamu.edu',
                isAdmin: 'True', role: 'Officer', bio: 'I\'m Ben'
    )
  end

  # Sunny Day Cases
  it 'is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  # Rainy Day Cases
  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).not_to(be_valid)
  end

  it 'is not valid without a user_id' do
    subject.user_id = nil
    expect(subject).not_to(be_valid)
  end
end

# Portfolio unit tests
RSpec.describe(Album, type: :model) do
  subject do
    described_class.new(name: 'Panels', caption: 'panels I drew', user_id: userOwner.id, portfolio_id: portfolioOwner.id)
  end

  let(:userOwner) do
    User.create(username: 'ben', email: 'ben@tamu.edu',
                isAdmin: 'True', role: 'Officer', bio: 'I\'m Ben'
    )
  end

  let(:portfolioOwner) do
    Portfolio.create(title: 'images by me', user_id: userOwner.id)
  end

  # Sunny Day Cases
  it 'is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  # Rainy Day Cases
  it 'is not valid without a title' do
    subject.name = nil
    expect(subject).not_to(be_valid)
  end

  it 'is not valid without a user_id' do
    subject.user_id = nil
    expect(subject).not_to(be_valid)
  end

  it 'is not valid without a portfolio_id' do
    subject.portfolio_id = nil
    expect(subject).not_to(be_valid)
  end
end

RSpec.describe(Image, type: :model) do
  subject do
    described_class.new(title: 'Image', caption: 'An Image', showOnPortfolio: 'True', users_id: imageowner.id)
  end

  let(:imageowner) do
    User.create(username: 'ben', email: 'ben@tamu.edu',
                isAdmin: 'True', role: 'Officer', bio: 'I\'m Ben'
    )
  end

  before do
    subject.imageLink.attach(io: File.open(Rails.root.join('spec', 'trolltunga-fjord.jpg')),
                             filename: 'trolltunga-fjord.jpg',
                             content_type: 'application/jpg'
                            )
  end

  it 'does not save without a link' do
    subject.imageLink = nil
    expect(subject).not_to(be_valid)
  end

  it 'does not save without a user FK' do
    subject.users_id = nil
    expect(subject).not_to(be_valid)
  end

  it 'saves with a title' do
    expect(subject).to(be_valid)
  end

  it 'saves with a caption' do
    expect(subject).to(be_valid)
  end

  it 'saves with a FK' do
    expect(subject).to(be_valid)
  end

  it 'saves with a Link' do
    expect(subject).to(be_valid)
  end
end
