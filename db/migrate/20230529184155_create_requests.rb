class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string   :title
      t.integer  :request_type_id
      t.integer  :village_id
      t.string   :registry_number
      t.date     :registry_date
      t.string   :year
      t.integer  :user_id
      t.boolean  :payment_done, default: false
      t.string   :uuid

      t.timestamps
    end
  end
end
