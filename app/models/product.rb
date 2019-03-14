class Product < ApplicationRecord
  belongs_to :seller
  has_many :line_items
  has_many :orders, through: :line_items 
  
  before_create :default_values
  before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image_url, PictureUploader

  validates :title, :description, presence: true
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true


  def default_values
    if self.popularity.nil?  || self.popularity.blank? 
      self.popularity = 0
    end
  end



  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end

end
