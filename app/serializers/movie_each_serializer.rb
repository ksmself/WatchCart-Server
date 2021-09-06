class MovieEachSerializer < Panko::Serializer
  attributes :id, :title, :description, :stars, :year, :category_id, :director_id, :image_path

  delegate :image_path, to: :object

  # option을 가지고 오고 싶다면
  # has_many :options, serializer: OptionEachSerializer
  # 그러면 GET /movies를 했을 때 option도 담기게 된다
end