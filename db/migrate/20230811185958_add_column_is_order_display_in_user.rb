class AddColumnIsOrderDisplayInUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_order_display, :boolean, default: false
  end
end
