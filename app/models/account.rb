class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to:accountable, polymorphic: true
  ACCOUNT_TYPES=["SuperAccount", "Buyer", "Seller"]
  attr_accessor :type
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
