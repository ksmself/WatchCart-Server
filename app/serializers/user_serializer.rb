  class UserSerializer < Panko::Serializer
    include ImagableSerializer

    attributes :id, :email, :name, :description, :image_ids
    
    has_many :liked_movies, serializer: MovieSerializer
    has_many :orders, serializer: OrderSerializer
  end
