class LineItem < ApplicationRecord
  validates :option_id, presence: true
  validates :quantity, presence: true

  belongs_to :option, optional: true
  belongs_to :order
end
