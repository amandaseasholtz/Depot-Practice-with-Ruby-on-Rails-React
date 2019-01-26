class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
  end
  def home
  end
end
