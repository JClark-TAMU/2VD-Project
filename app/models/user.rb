class User < ApplicationRecord
    validates :role, presence: true
    validates :username, presence: true 
    validates :email, presence: true
    validates :bio, presence: true

    validate :isAdmin
    #Only officers
    scope :officers, -> { where(isAdmin: true)}
    #Only members
    scope :members, -> { where("username != 'guest'")}
end
