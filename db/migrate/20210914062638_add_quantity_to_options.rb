class AddQuantityToOptions < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :quantity, :integer
  end
end
