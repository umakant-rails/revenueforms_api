class CreateVillages < ActiveRecord::Migration[7.0]
  def change
    create_table :villages do |t|
      t.integer    :district_id
      t.integer    :tehsil_id

      t.integer    :ri_code
      t.string    :ri
      t.string    :ri_eng

      t.string    :halka_number
      t.string    :halka_name
      t.string    :halka_name_eng
      t.string    :village_code
      t.string    :village
      t.string    :village_eng
      t.string    :bhucode_lr
      t.string    :lgd_code

      t.string    :data_available_since
      t.string    :map_available
      t.string    :ulb_name
      t.string    :village_type
      t.string    :is_khasra_available
      t.integer   :khasra_count
      t.float     :total_area_khasra
      t.integer   :map_parcel_count
      t.float     :total_area_map
      t.boolean   :aabaadi_survey
      t.integer   :ulnpin_plot
      t.integer   :ulpin_khasra
      t.string    :patwari_name
      t.string    :mobile
      
      t.timestamps
    end
  end
end