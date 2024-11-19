class KhasraBattank < ApplicationRecord
  belongs_to :request
  belongs_to :khasra
  belongs_to :participant, optional: true
  
  validates :new_khasra, :rakba, presence: true
end
