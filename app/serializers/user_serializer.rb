  class UserSerializer < Panko::Serializer
    attributes :id, :email, :name, :address1
    
    has_many :liked_movies, only: [:id, :title, :image_path], serializer: MovieSerializer
    has_many :good_movies, only: [:id, :title, :image_path], serializer: MovieSerializer
    has_many :bad_movies, only: [:id, :title, :image_path], serializer: MovieSerializer
    has_many :orders, serializer: OrderSerializer
  end
