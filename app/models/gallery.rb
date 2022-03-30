class Gallery < ApplicationRecord
    validates :prompt, presence: true

    #gallery relations
    has_many :image
end
