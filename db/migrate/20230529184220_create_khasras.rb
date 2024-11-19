class CreateKhasras < ActiveRecord::Migration[7.0]
  def change
    create_table :khasras do |t|
      t.string  :khasra
      t.string  :rakba
      t.string  :sold_rakba
      t.string  :unit
      t.integer :request_id
      t.integer :village_id

      t.timestamps
    end
  end
end
