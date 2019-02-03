class StoreController < ApplicationController
  before_action :set_cart
 
  def index
    @products = Product.order(:title)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
		def set_cart
			@cart = Cart.find(session[:cart_id])
		rescue ActiveRecord::RecordNotFound
			@cart = Cart.create
			session[:cart_id] = @cart.id
		end
  end

