class ParticipantType < ApplicationRecord
  has_many :participants

  scope :pa, ->() { where('parent_id is null') }
  scope :fout_person, ->() { where('parent_id is null') }
  scope :fout_person, ->() { where('parent_id is null') }

end
