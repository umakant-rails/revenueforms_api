class Order < ApplicationRecord
  # include OrderConcerns::Razorpay
  belongs_to :user
  has_one :order_transaction, as: :transactionable


  def self.place_a_order(amount)
    order = create_order(amount)
  end

  def self.get_a_order(payment_id)
    order = fetch_payment(payment_id)
  end

end
