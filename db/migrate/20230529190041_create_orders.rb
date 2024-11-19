class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :payment_id
      t.string :order_id
      t.string :signature
      t.integer :amount
      t.boolean :status
      
      t.timestamps
    end
  end
end
