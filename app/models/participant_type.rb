class ParticipantType < ApplicationRecord
  has_many :participants

  scope :pa, ->() { where('parent_id is null') }
  scope :fout_person, ->() { where('parent_id is null') }
  scope :fout_person, ->() { where('parent_id is null') }

  def self.get_participants(request)
    if request.request_type.name == "नामांतरण"
      self.where("name in (?)", ["क्रेता", "विक्रेता", "करांदा-आम"])
    elsif request.request_type.name == "फौती"
      self.where("name in (?)", ["फौत व्यक्ति", "वारसान"])
    elsif request.request_type.name.index("बटवारा") >= 0
      self.where("name in (?)", ["मूल भू स्वामी", "नए हिस्सेदार", "मूल भू स्वामी एवं हिस्सेदार"])
    end
  end

end
