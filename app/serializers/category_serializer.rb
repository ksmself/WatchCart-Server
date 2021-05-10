class CategorySerializer < Panko::Serializer
  attributes :id, :title, :position, :image_path

  delegate :image_path, to: :object
end
