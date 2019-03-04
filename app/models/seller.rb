class Seller < ApplicationRecord
    has_many :products
    has_one :account, as: :accountable
end
