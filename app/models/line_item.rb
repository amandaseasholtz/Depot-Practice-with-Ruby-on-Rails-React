class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart


  def total_price
    product.price * quantity
  end


  def decrement
    quantity = quantity - 1 
  end
end
