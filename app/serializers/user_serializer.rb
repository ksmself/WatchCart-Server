  class UserSerializer < Panko::Serializer
    include ImagableSerializer

    attributes :id, :email, :name, :description
    
    has_many :liked_movies, only: [:id, :title, :image_path], serializer: MovieSerializer
    has_many :orders, serializer: OrderSerializer
  end
