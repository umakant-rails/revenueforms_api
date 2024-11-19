class BlankForm < ApplicationRecord
  belongs_to :form_category

  validates :eng_name, :hindi_name,  presence: true 
end
