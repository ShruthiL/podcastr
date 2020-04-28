class Review < ApplicationRecord
    validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
    validates :user_id, presence: true
    validates :podcast_id, presence: true

    belongs_to :user
    belongs_to :podcast
end
