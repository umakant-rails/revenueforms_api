class User < ApplicationRecord
  has_many :requests
  has_many :orders
  has_many :payment_transactions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def is_admin
    self.role_id == 1
  end

end
