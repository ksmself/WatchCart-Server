  class UserSerializer < Panko::Serializer
    include ImagableSerializer

    attributes :id, :email, :name, :description, :image_ids

  end
