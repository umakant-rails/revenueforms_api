class Participant < ApplicationRecord

  has_many :children, class_name: :Participant, foreign_key: :parent_id
  has_many :varsan, class_name: :Participant, foreign_key: :parent_id
  belongs_to :parent, class_name: :Participant, foreign_key: :parent_id, optional: true
  belongs_to :request
  belongs_to :participant_type
  
  scope :applicant, -> () { find_by_attribute(is_applicant: true)}
  # scope :applicant, -> () { where(is_applicant: true)}
  scope :buyers, -> () { where("participant_type_id = 1")}
  scope :sellers, -> () { where("participant_type_id = 2")}
  scope :karanda_aam, -> () { where("participant_type_id = 3")}

  scope :land_owner, -> () { where("participant_type_id in (?)", 
    ParticipantType.where("name in (?)", ["मूल भू स्वामी", "मूल भू स्वामी एवं हिस्सेदार"]).pluck(:id)) }
  scope :hissedar, -> () { where("participant_type_id in (?)", 
    ParticipantType.where("name in (?)", ["नए हिस्सेदार", "मूल भू स्वामी एवं हिस्सेदार" ]).pluck(:id)) }
  scope :batwara_daughters, -> () { where("relation =? and depth != 0", "पुत्री")}

  scope :fout_person, ->() { where('parent_id is null and death_date is not null') }
  scope :fout_varsan, ->() { where('is_dead=? and parent_id is not null', true) }
  scope :fout_participants, ->() { where('is_dead=?', true) }
  scope :son, ->() { where("relation_to_deceased='पुत्र'")}
  scope :daughter, ->() { where("relation_to_deceased='पुत्री'")}
  scope :wife_husband, ->() { where("relation_to_deceased in (?) ", ['पत्नी', 'बेवा', 'पति']  )}
  scope :varsan, ->() { where("parent_id is not null")}

  validates :name, :relation, :gaurdian, :address,  presence: true 

  RELATIONS = ['पुत्र','पुत्री', 'पत्नी', 'बेवा']
  RELATIONS_TO_DECEASED = ['पुत्र','पुत्री', 'पत्नी', 'पति', 'अन्य']
  SWAMITVA_STATUS=[["पूर्ण भूमि स्वामी", false], ["सह-खातेदार", true]]
  BOOLEAN_STATUS =[["नहीं ", false], ["हाँ", true]]

end
