class User < ApplicationRecord
  paginates_per 8
  include ImageUrl
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :items, dependent: :nullify
  has_many :orders, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_movies, through: :likes, source: :movie

  has_many :ratings, dependent: :destroy
  has_many :movie_good, -> { where status: :good }, class_name: 'Rating'
  has_many :rated_good, through: :movie_good, class_name: 'Movie', source: :movie
  has_many :movie_bad, -> { where status: :bad }, class_name: 'Rating'
  has_many :rated_bad, through: :movie_bad, class_name: 'Movie', source: :movie
  enum gender: { unknown: 0, male: 1, female: 2 }
end
