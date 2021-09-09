class AddNameToOption < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :name, :string
  end
end
