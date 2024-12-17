class CreateBlankForms < ActiveRecord::Migration[7.0]
  def change
    create_table :blank_forms do |t|
      t.integer :form_category_id
      t.string  :eng_name
      t.string  :hindi_name
      t.string  :form_name     
      t.string  :category
      t.text    :content

      t.timestamps
    end
  end
end
