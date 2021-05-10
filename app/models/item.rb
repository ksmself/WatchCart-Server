class Item < ApplicationRecord
  include ImageUrl
  include Imagable
  belongs_to :user
  belongs_to :category
  paginates_per 10
  enum status: { active: 0, disabled: 1 }
end
