class AddActorToMovie < ActiveRecord::Migration[6.0]
  def change
    add_reference :movies, :actor, polymorphic: true
  end
end
