class CreateTehsils < ActiveRecord::Migration[7.0]
  def change
    create_table :tehsils do |t|
      t.integer :district_id
      t.integer :code
      t.string :name
      t.string :name_eng

      t.timestamps
    end
  end
end
