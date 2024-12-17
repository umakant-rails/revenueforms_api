class Village < ApplicationRecord

  belongs_to :tehsil

  has_one :district, through: :tehsil
end
