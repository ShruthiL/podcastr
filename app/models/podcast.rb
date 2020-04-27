class Podcast < ApplicationRecord
    validates :name, presence: true
    validates :url, presence: true, uniqueness: true

    has_many :reviews
end