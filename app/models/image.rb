class Image < ApplicationRecord
    belongs_to :User, optional: true, foreign_key: "users_id", class_name: "User"
    belongs_to :Portfolio, optional: true, foreign_key: "portfolios_id", class_name: "Portfolio"

    validates :title, presence: true
    validates :caption, presence: true
    validates :showOnPortfolio, inclusion: [true, false]
    validates :imageLink, presence: true
    validates :users_id, presence: true

    has_one_attached :imageLink

    scope :ownedby, ->(user) {where(users_id: user)}
    scope :inportfolio, ->(portfolio) {where(portfolios_id: portfolio)}
    scope :publicimages, -> {where(showOnPortfolio: true)}
    scope :hiddenimages, -> {where(showOnPortfolio: false)}
end
