class Category < ApplicationRecord
  include ImageUrl
  validates :title, presence: true
  has_many :items, dependent: :nullify
end
