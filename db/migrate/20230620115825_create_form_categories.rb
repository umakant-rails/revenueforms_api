class CreateFormCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :form_categories do |t|
      t.integer :form_section_id
      t.string :hindi_name
      t.string :eng_name
      t.timestamps
    end
  end
end
