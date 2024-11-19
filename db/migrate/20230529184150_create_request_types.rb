class CreateRequestTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :request_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
