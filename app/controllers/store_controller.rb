class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
 
  def index
    @products = Product.order(:popularity).reverse_order
    @counter = session_counter
  end 
  def search
    products = Product.where("title LIKE '%#{params[:query]}%'")
    render json: products
  end
  private 
    def sort_by
       %w(title
          price
          popularity).include?(params[:sort_by]) ? params[:sort_by] : 'popularity'
    end
    def order
       %w(asc desc).include?(params[:order]) ? params[:order] : 'asc'
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
            @spa = true
              render 'index_spa'
          # the else case below is by default
          else
             render 'index'
          end
      }
      format.json {render json: Product.order(sort_by + ' ' + order)}
  end
    
  end
end 
