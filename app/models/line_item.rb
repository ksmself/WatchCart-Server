class LineItem < ApplicationRecord
  enum status: { uncomplete: 0, complete: 1 }

  validates :option_id, presence: true
  validates :quantity, presence: true

  belongs_to :option, optional: true
  belongs_to :order

  ransacker :status, formatter: proc { |status| statuses[status] }
end
