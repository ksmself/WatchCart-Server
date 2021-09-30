class User < ApplicationRecord
  paginates_per 8
  include ImageUrl
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :items, dependent: :nullify
  has_many :orders, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_movies, through: :likes, source: :movie
  has_many :goods, dependent: :destroy
  has_many :good_movies, through: :goods, source: :movie
  has_many :bads, dependent: :destroy
  has_many :bad_movies, through: :bads, source: :movie
  enum gender: { unknown: 0, male: 1, female: 2 }
end
