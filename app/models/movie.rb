class Movie < ApplicationRecord
    include ImageUrl
    validates :title, presence: true
    belongs_to :category
    belongs_to :director
    has_many :plays
    has_many :played_actors, through: :plays, source: :actor
  end