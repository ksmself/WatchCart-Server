  class UserSerializer < Panko::Serializer
    attributes :id, :email, :name, :address1
    
    has_many :liked_movies, only: [:id, :title, :image_path], serializer: MovieSerializer
    has_many :orders, serializer: OrderSerializer

    has_many :rated_good, serializer: MovieSerializer
    has_many :rated_bad, serializer: MovieSerializer
  end
