class RemoveActorFromMovies < ActiveRecord::Migration[6.0]
  def change
    remove_reference :movies, :actor, polymorphic: true
  end
end
