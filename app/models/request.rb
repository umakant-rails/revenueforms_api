class Request < ApplicationRecord
  
  has_many :participants, dependent: :destroy
  has_many :khasras, dependent: :destroy
  belongs_to :village
  belongs_to :user
  belongs_to :request_type
  has_many :participant_types, through: :request_type
  has_one :payment_transaction, as: :transactionable
  has_many :khasra_battanks, dependent: :destroy
  validates :title, :request_type_id, :year, presence: true  

  def self.current_revenue_year
    year_range = Date.parse("01/04/#{Date.today.year}")..Date.parse("01/04/#{Date.today.year+1}")
    year = (year_range === Date.today) ? "#{Date.today.strftime("%Y").to_s}-#{Date.today.next_year.strftime("%y").to_s}" :  nil
  end

  def applicant
    participants.find_by(is_applicant: true)
  end

  def applicant_name
    applicant = self.applicant
    applicant.blank? ? 'Not Available' : applicant.name + " " + applicant.relation + " " + applicant.gaurdian 
  end

  def get_participant_types
    if self.request_type.name == "नामांतरण"
      ParticipantType.where("name in (?)", ["क्रेता", "विक्रेता", "करांदा-आम"])
    elsif self.request_type.name == "फौती"
      ParticipantType.where("name in (?)",  ["फौत व्यक्ति", "वारसान"])
    elsif self.request_type.name.index("बटवारा") >= 0
      ParticipantType.where("name in (?)",  ["मूल भू स्वामी", "नए हिस्सेदार", "मूल भू स्वामी एवं हिस्सेदार"])
    end
  end

  def get_hissedar_battanks
    new_khasra_battanks = self.khasra_battanks.where("group_id is null").order("new_khasra asc") rescue nil
    hissedar_battanks = self.khasra_battanks.where("group_id is not null").order("group_id ASC") #.pluck(:participant_ids).uniq
    group_id_count = hissedar_battanks.group("group_id").count
    participant_ids = ''
    participant_names = ''

    hissedar_battanks = hissedar_battanks.map.with_index do |kh_battank, index| 
      if(participant_ids != kh_battank.participant_ids)
        participant_ids = kh_battank.participant_ids
        participants = Participant.where("id in (?)", participant_ids.split(","))
        participants = participants.map{ |p| "#{p.name} #{p.relation} #{p.gaurdian}" }
        participant_names = participants.join(", ")
      end
      village = kh_battank.village.attributes.merge({tehsil: kh_battank.village.tehsil.name})
      kh_battank.attributes.merge({
        village: village,
        hissedars: participant_names,
        khasra_count:group_id_count[kh_battank.group_id]
      })
    end

    return hissedar_battanks
  end

end
