class ActorSerializer < Panko::Serializer
  attributes :id, :name, :played_movies

  has_many :played_movies, serializer: MovieSerializer
end