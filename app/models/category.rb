class Category < ApplicationRecord
  paginates_per 4

  validates :title, presence: true
  has_many :movies, dependent: :nullify
end
