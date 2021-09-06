class MovieSerializer < Panko::Serializer
  attributes :id, :title, :description, :stars, :year, :category_id, :director_id, :image_path

  delegate :image_path, to: :object
end