class PaymentTransaction < ApplicationRecord
  belongs_to :transactionable, polymorphic: true
  belongs_to :user

  validates :amount, presence: true
end
