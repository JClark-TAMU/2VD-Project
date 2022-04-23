class User < ApplicationRecord
  validates :role, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :bio, presence: true

  validate :isAdmin
  # Only officers
  scope :officers, -> { where(isAdmin: true) }
  # Only members
  scope :members, -> { where("role != 'guest'") }

  # relations for users
  has_one :portfolio
  has_many :images, through: :portfolio

  #permission function
  # If admin or owner, return true
  def is_permitted?
    return self.isAdmin || (self.email == current_admin.email)
  end
end
