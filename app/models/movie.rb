class Movie < ApplicationRecord
    include ImageUrl
    validates :title, presence: true
    belongs_to :category
    belongs_to :director
    has_many :plays
    has_many :options, dependent: :destroy
    has_many :played_actors, through: :plays, source: :actor
    has_many :likes, dependent: :destroy
    has_many :ratings, dependent: :destroy
  end