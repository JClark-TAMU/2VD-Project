class Portfolio < ApplicationRecord
    validates :title, presence: true
    validates :user_id, presence: true

    belongs_to :user
end
