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

  member_roles = ['Member','Alumni','Guest']
  admin_roles = ['Member','Alumni','Guest','Officer','Secretary','Social Media Officer','Treasurer','Vice President','President']
  #permission function
  # If admin or owner, return true
  def is_permitted?
    return self.isAdmin || (self.email == current_admin.email)
  end
end
