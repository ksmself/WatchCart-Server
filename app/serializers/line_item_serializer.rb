class LineItemSerializer < Panko::Serializer
  attributes :id, :option_id, :order_id, :quantity, :status 

  belongs_to :option, serializer: OptionSerializer
end