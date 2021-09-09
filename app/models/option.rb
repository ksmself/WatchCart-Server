class Option < ApplicationRecord
  validates :name, presence: true
  belongs_to :movie
end
