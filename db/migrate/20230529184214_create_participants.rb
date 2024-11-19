class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants do |t|
      t.string    :name
      t.string    :relation
      t.string    :gaurdian
      t.string    :address
      # t.boolean   :karanda_aam
      t.boolean   :is_dead
      t.date      :death_date
      t.boolean   :is_nabalig
      t.string    :balee
      t.integer   :parent_id
      t.integer   :request_id
      t.integer   :depth
      t.string    :relation_to_deceased
      t.boolean   :is_shareholder, default: false
      t.integer   :participant_type_id
      t.boolean   :total_share_sold, default: false
      t.boolean   :is_applicant, default: false

      t.timestamps
    end
  end
end
