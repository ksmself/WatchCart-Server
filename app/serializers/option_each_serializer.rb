class OptionEachSerializer < Panko::Serializer
  attributes :id, :movie_id, :name, :price

  has_one :movie, only: [:id, :title, :image_path], serializer: MovieEachSerializer
end