class Khasra < ApplicationRecord
  belongs_to :request
  belongs_to :village
  has_many :khasra_battanks
  
  validates :khasra, :rakba,  presence: true 

end
