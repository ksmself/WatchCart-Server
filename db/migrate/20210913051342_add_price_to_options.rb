class AddPriceToOptions < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :price, :integer
  end
end
