class CreateDistricts < ActiveRecord::Migration[7.0]
  def change
    create_table :districts do |t|
      t.integer :code
      t.string :name
      t.string :name_eng

      t.timestamps
    end
  end
end
