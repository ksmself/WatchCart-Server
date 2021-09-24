class LineItemSerializer < Panko::Serializer
  attributes :id, :option_id, :order_id, :quantity, :status

  has_one :option, serializer: OptionSerializer
end