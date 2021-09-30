class Movie < ApplicationRecord
    include ImageUrl
    validates :title, presence: true
    belongs_to :category
    belongs_to :director
    has_many :plays
    has_many :options, dependent: :destroy
    has_many :played_actors, through: :plays, source: :actor
    has_many :likes, dependent: :destroy
    has_many :goods, dependent: :destroy
    # has_many :good_users, through: :goods, source: :user
    has_many :bads, dependent: :destroy
    # has_many :bad_users, through: :bads, source: :user
  end