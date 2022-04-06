class Album < ApplicationRecord
    validates :name, presence: true
    validates :caption, presence: true

    #portfolio relations
    belongs_to :portfolio
    belongs_to :user
    has_many :image

    scope :ownedby, ->(user) {where(user_id: user)}
    scope :inportfolio, ->(portfolio) {where(portfolio_id: portfolio)}
end
