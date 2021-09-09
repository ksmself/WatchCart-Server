class DropMoviesActors < ActiveRecord::Migration[6.0]
  def change
    drop_table :actors_movies
  end
end
