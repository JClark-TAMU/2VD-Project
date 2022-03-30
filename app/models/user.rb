class User < ApplicationRecord
  validates :role, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :bio, presence: true

  validate :isAdmin
  # Only officers
  scope :officers, -> { where(isAdmin: true) }
  # Only members
  scope :members, -> { where("username != 'guest'") }

  # relations for users
  has_one :portfolio
  has_many :images, through: :portfolio
  # Decide: "has_many :images" or "has_many :images, through :portfolio,:gallery"
end
