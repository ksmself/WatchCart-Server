class ChangeColumnsFromMovies < ActiveRecord::Migration[6.0]
  def change
    change_column :movies, :stars, :decimal 
  end
end
