class Category < ApplicationRecord
  paginates_per 4

  include ImageUrl
  validates :title, presence: true
  has_many :items, dependent: :nullify
  has_many :movies, dependent: :nullify
end
