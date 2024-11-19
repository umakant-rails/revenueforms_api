class FormCategory < ApplicationRecord
  belongs_to :form_section
  has_many :blank_forms
end
