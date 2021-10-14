class Rating < ApplicationRecord
  enum status: { good: 0, bad: 1 }

  belongs_to :user
  belongs_to :movie

  ransacker :status, formatter: proc { |status| statuses[status] }
end
