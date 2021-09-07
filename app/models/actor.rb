class Actor < ApplicationRecord
    has_many :plays
    
    has_many :played_movies, through: :plays, source: :movie
end