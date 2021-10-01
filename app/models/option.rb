class Option < ApplicationRecord
  validates :name, presence: true
  belongs_to :movie

  has_many :line_items, dependent: :nullify
end
