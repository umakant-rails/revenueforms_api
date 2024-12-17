class District < ApplicationRecord
  has_many :tehsils

  has_many :villages, through: :tehsils
end
