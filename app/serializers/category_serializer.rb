class CategorySerializer < Panko::Serializer
  attributes :id, :title, :position, :image_path

  delegate :image_path, to: :object

  has_many :movies, serializer: MovieSerializer
end
