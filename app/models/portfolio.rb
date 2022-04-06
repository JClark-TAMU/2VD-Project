class Portfolio < ApplicationRecord
  validates :title, presence: true
  validates :user_id, presence: true

    #portfolio relations
    belongs_to :user
    has_many :image
    has_many :Album
end
