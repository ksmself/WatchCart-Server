class Movie < ApplicationRecord
    include ImageUrl
    validates :title, presence: true
    belongs_to :category
    belongs_to :director
  end