class Album < ApplicationRecord
    validates :name, presence: true
    validates :size, presence: true

    #portfolio relations
    belongs_to :portfolio
    belongs_to :user
    has_many :image

    scope :ownedby, ->(user) {where(users_id: user)}
    scope :inportfolio, ->(portfolio) {where(portfolios_id: portfolio)}
end
