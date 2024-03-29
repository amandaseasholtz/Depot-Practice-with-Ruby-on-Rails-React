class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :accountable, polymorphic: true
  ACCOUNT_TYPES=["SuperAccount", "Buyer", "Seller"] 
  attr_accessor :type
end
