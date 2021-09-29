class CategorySerializer < Panko::Serializer
  attributes :id, :title

  has_many :movies, only: [:id, :title, :image_path], serializer: MovieSerializer
end
