class OptionSerializer < Panko::Serializer
  attributes :id, :movie_id, :name, :price, :quantity

  has_one :movie, only: [:id, :title, :image_path] ,serializer: MovieSerializer
end