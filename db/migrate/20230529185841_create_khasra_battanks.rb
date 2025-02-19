class CreateKhasraBattanks < ActiveRecord::Migration[7.0]
  def change
    create_table :khasra_battanks do |t|
      t.integer :khasra_id
      t.string  :new_khasra
      t.float   :rakba
      t.integer :request_id
      t.string  :participant_ids
      t.string  :group_id
      t.integer :village_id

      t.timestamps
    end
  end
end
