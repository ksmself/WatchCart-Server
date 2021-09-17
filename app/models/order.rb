class Order < ApplicationRecord
  enum status: { orderUncompleted: 0, orderCompleted: 1, shipPreparing: 2, shipping: 3, shipCompleted: 4 }
  # 주문안함, 주문완료, 배송준비중, 배송중, 배송완료
  
  belongs_to :user, optional: true 
  # order가 user를 필수로 상속하는 것은 아니기 때문
	# ex) user_id가 null이 되어도 order는 삭제되면 안되니까

  has_many :line_items, dependent: :destroy
  # order 삭제하면 line_item도 삭제

  ransacker :status, formatter: proc { |status| statuses[status] }
end
