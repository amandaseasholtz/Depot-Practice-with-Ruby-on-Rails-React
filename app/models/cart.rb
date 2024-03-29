class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def add_product(product)
        current_item = line_items.find_by(product_id: product.id)
        if current_item
            current_item.quantity += 1
        else
            current_item = line_items.build(product_id: product.id)
        end
        current_item
    end

    def remove_line_item(product)
        item = line_items.find_by(product_id: product.id)
        item.quantity -= 1
        
        item
    end

    def emtpy_cart_popularity(line_item)
        line_item.product.popularity = (line_item.product.popularity - line_item.quantity)
        line_item.product.update_attribute(:popularity, line_item.product.popularity)
        line_item.product.save
    end
    
    def total_price
        line_items.to_a.sum { |item| item.total_price }
    end

end
