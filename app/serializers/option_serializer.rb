class OptionSerializer < Panko::Serializer
  attributes :id, :movie_id, :name, :price, :quantity

  has_one :movie, serializer: MovieSerializer
end