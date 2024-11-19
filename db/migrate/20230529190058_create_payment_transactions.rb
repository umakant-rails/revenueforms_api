class CreatePaymentTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_transactions do |t|
      t.integer :user_id
      t.integer :transactionable_id
      t.string  :transactionable_type
      t.string  :app_number
      t.integer :amount
      t.integer :credit
      t.integer :debit
      
      t.timestamps
    end
  end
end
