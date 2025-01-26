class CreateVisitorLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :visitor_logs do |t|
      t.string :ip_address
      t.string :page_url
      t.date :visit_date

      t.timestamps
    end
  end
end
