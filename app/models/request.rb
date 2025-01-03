class Request < ApplicationRecord
  
  has_many :participants
  has_many :khasras
  belongs_to :village
  belongs_to :user
  belongs_to :request_type
  has_many :participant_types, through: :request_type
  has_one :payment_transaction, as: :transactionable
  has_many :khasra_battanks

  validates :title, :request_type_id, :year, presence: true 
  # accepts_nested_attributes_for :khasras, allow_destroy: true

  UNITS = ['व.फु.', 'व.मी.', 'हे.']
  TEMPLATES = [['प्रारूप-35', 'pdf-paragraph-35'], ['प्रारूप-40', 'pdf-paragraph-40'], ['प्रारूप-45', 'pdf-paragraph-45']]
  FAUTI_ORDER_PRAROOP = [["आदेश प्रारूप-1", "p1"], ["आदेश प्रारूप-2", "p2"], ["आदेश प्रारूप-3", "p3"]]
  NAMANTARAN_ORDER_PRAROOP = [["आदेश प्रारूप-1", "p1"], ["आदेश प्रारूप-2", "p2"]]
  SANJARA_PRAROOP = [["संजरा प्रारूप-1", "p1"], ["संजरा प्रारूप-2", "p2"]]

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

end
