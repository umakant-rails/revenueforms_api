class User < ApplicationRecord
  has_many :requests
  has_many :orders
  has_many :payment_transactions

  devise :database_authenticatable, :registerable, :validatable, :timeoutable, :confirmable,
    :recoverable, :jwt_authenticatable, jwt_revocation_strategy: self

  def is_admin
    self.role_id == 1
  end

end
