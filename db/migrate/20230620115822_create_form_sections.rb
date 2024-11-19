class CreateFormSections < ActiveRecord::Migration[7.0]
  def change
    create_table :form_sections do |t|
      t.string :hindi_name
      t.string :eng_name
      t.timestamps
    end
  end
end
