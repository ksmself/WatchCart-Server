class Category < ApplicationRecord
  validates :title, presence: true
  has_many :movies, dependent: :nullify
end
