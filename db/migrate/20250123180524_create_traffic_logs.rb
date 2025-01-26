class CreateTrafficLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :traffic_logs do |t|
      t.date :visit_date
      t.string :ip_address
      t.integer :visited_page

      t.timestamps
    end
  end
end
