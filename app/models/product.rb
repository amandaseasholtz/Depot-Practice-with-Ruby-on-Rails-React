class Product < ApplicationRecord
    has_many :line_items
    has_many :orders, through: :line_items 
    belongs_to :seller
    before_destroy :ensure_not_referenced_by_any_line_item
    mount_uploader :image_url, ImageUploader
    validates :title, :description, :image_url, :popularity, presence: true
    validates :title, uniqueness: true
    validates :image_url, allow_blank: true, format: {
        with:
        %r{\.(gif|jpg|png)\Z}i,
        message: 'must be a URL for GIF, JPG or PNG image.'
    }
    validates :price, numericality: { greater_than_or_equal_to: 0.01 }

    private

    def ensure_not_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, 'Line Items present')
            throw :abort
        end
    end
    
end
