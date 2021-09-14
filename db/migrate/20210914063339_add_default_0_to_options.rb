class AddDefault0ToOptions < ActiveRecord::Migration[6.0]
  def change
    change_column_default :options, :quantity, from: nil, to: 0
  end
end
