class LineItemSerializer < Panko::Serializer
  attributes :id, :option_id, :order_id, :quantity, :created_at, :updated_at 
end