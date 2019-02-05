class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
 
  def index
    @products = Product.order(:popularity).reverse_order
    @counter = session_counter

    
  end 
  def session_counter  
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter]+=1
    end 

    if session[:counter] > 5
        flash.notice = "You have been here #{session[:counter]} 
          times. Please go ahead and buy something "
      
    end

    respond_to do |format|
      format.html {
          if (params[:spa] && params[:spa] == "true")
              render 'index_spa'
          # the else case below is by default
          else
             render 'index'
          end
      }
      format.json {render json: @products}
  end
    
  end
end 
