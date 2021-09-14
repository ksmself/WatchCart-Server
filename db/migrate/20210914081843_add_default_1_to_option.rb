class AddDefault1ToOption < ActiveRecord::Migration[6.0]
  def change
    change_column_default :options, :quantity, from: 0, to: 1
  end
end
