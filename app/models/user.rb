class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :requests
  has_many :orders
  has_many :payment_transactions

  devise :database_authenticatable, :registerable, :validatable, :timeoutable, #:confirmable,
    :recoverable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :username, :email, presence: true
  validates_length_of :password, :within => 8..20, :if => :password_required?
  
  def is_admin
    self.role_id == 1
  end

  def compare_current_passowrd(password)
    return User.find_for_authentication(email:self.email).valid_password?(password)
  end

  def change_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

end
