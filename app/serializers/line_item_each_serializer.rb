class LineItemEachSerializer < Panko::Serializer
  attributes :id, :option_id, :order_id, :quantity, :status
end