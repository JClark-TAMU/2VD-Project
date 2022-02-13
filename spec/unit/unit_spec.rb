# location: spec/unit/unit_spec.rb
require 'rails_helper'

# User unit tests
RSpec.describe User, type: :model do
    subject do
      described_class.new(username: 'ben', password: 'password', email: 'ben@tamu.edu',
                        isAdmin: 'True', role: 'Officer', bio: 'I\'m Ben')
    end
  
    # Sunny Day Cases
    it 'role is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'isAdmin is valid with valid attributes' do
        expect(subject).to be_valid
    end
  
    # Rainy Day Cases
    it 'role is not valid without a name' do
      subject.role = nil
      expect(subject).not_to be_valid
    end
  end
  
RSpec.describe User, type: :model do
    subject do
      described_class.new(username: 'Froggers', password: '12345', email: 'gmail@gmail.com', isAdmin: 'False', bio: 'I like to draw', portfolioID: '1')
    end
  
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  
    it 'is not valid without a name' do
      subject.bio = nil
      expect(subject).not_to be_valid
    end
end
