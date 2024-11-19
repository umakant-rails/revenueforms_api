class CreateKhasraParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :khasra_participants do |t|
      t.string    :khasra_id
      t.integer   :participant_id
      t.string    :rakba
      t.timestamps
    end
  end
end
