class CreateVillages < ActiveRecord::Migration[7.0]
  def change
    create_table :villages do |t|
      t.string    :district
      t.string    :district_eng
      t.string    :tehsil
      t.string    :tehsil_eng
      t.string    :ri
      t.string    :halka_number
      t.string    :halka_name
      t.string    :village_code
      t.string    :village
      t.string    :village_eng
      t.string    :bhucode_lr
      t.string    :lgd_code
      t.integer   :total_khasra
      t.integer   :total_area
      
      t.timestamps
    end
  end
end
