class PlaySerializer < Panko::Serializer
  attributes :id, :movie_id, :actor_id
  
  belongs_to :movies
  belongs_to :actors
end