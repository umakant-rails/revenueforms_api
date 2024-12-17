class Tehsil < ApplicationRecord
  has_many :villages
  belongs_to :district
end
