class V1::UserEachSerializer < V1::BaseSerializer
  include ImagableSerializer

  attributes :id, :email, :name, :description
end