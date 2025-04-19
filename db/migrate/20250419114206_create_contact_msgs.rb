class CreateContactMsgs < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_msgs do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :description

      t.timestamps
    end
  end
end
