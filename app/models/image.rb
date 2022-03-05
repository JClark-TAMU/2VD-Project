class Image < ApplicationRecord
    belongs_to :User, optional: true
    belongs_to :Portfolio, optional: true

    validates :title, presence: true
    validates :caption, presence: true
    validates :showOnPortfolio, presence: true
    validates :imageLink, presence: true
    validates :users_id, presence: true

    has_one_attached :imageLink
end
