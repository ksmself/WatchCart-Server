class MovieSerializer < Panko::Serializer
  attributes :id, :title, :description, :stars, :year, :category_id, :director_id, :image_path, :played_actors
  delegate :image_path, to: :object

  has_many :options, serializer: OptionSerializer
  has_many :played_actors, serializer: ActorSerializer, only: [:id, :name]
  has_one :director, only: [:id, :name]
end