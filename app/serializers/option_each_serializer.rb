class OptionEachSerializer < Panko::Serializer
  attributes :id, :movie_id, :name, :price

  has_one :movie, serializer: MovieEachSerializer
end