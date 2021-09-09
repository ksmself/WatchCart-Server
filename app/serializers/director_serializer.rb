class DirectorSerializer < Panko::Serializer
  attributes :id, :name

  has_many :movies, serializer: MovieSerializer
end