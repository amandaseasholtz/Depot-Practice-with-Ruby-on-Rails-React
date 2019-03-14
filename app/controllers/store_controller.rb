class StoreController < ApplicationController
  #include CurrentItem
  #before_action :set_item

  include CurrentCart
  before_action :set_cart

  def search
    products = Product.where("title LIKE '%#{params[:query]}%'")
    render json: products
  end

  def index
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] = session[:counter] + 1
    end
    # if session[:counter] >= 5
    #   flash[:alert] = "Hold on there pal! You've been on this page #{session[:counter]} times without purchasing anything!"
    # end
    @products = Product.order(:popularity).reverse
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

  def nocart
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
end
