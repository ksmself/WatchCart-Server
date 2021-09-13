class OrderSerializer < Panko::Serializer
  attributes :id, :user_id, :receiver_name, :receiver_phone, :address1, :total, :created_at, :updated_at, :status 
end