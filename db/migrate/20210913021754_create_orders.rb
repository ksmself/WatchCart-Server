class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string "receiver_name"
      t.string "receiver_phone"
      t.string "address1"
      t.integer "total"

      t.timestamps
    end
  end
end
