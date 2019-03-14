class Buyer < ApplicationRecord
    has_many :orders
    has_one :account, as: :accountable
end
