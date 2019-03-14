class LineItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_account!


  include CurrentCart
  before_action :set_cart

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])
  end

  def pundit_user
      current_account
    end
  def show_orders_for_seller
    seller = Seller.find(params[:id]) 
    authorize seller, :show_orders_for_seller?  
    products = seller.products
    @line_items = LineItem.where(product_id: products)
    products.each do |product|
      logger.info(product)
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    # Defined in the application controller. Finds
    # the current cart for this session, or creates a new one.
    product = Product.find(params[:product_id])
    @product = product
    session[:product_id] = @product.id
    @line_item = @cart.add_product(product)
    session[:counter] = 0
    product.popularity = product.popularity + 1
    product.update_attribute(:popularity, product.popularity)
    session[:product_popularity] = product.popularity #might delete

    # Reset catalog view counter in session
    session[:counter] = 0  

    respond_to do |format|
      if @line_item.save
        format.json {}
        format.html { redirect_to store_url }
        format.js { @current_item = @line_item }

      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    product = Product.find(session[:product_id])
    @product = product

    # Decrement the popularity
    if @product.popularity > 1
      @product.popularity -= 1
      @product.save!
    else 
      @product.popularity = 0
    end

    # Decrement the quantity 
    if @line_item.quantity > 1
      @line_item.quantity -= 1
      @line_item.save!
    else 
      @line_item.destroy
    end


    # Set the variable to decide if the cart should be re-hidden
    @hide_cart = @cart.line_items.empty?

    session[:hide_cart] = @hide_cart

    @current_item = @line_item

    respond_to do |format|
      format.json {}
      format.html { redirect_to @line_item.cart,
                    notice: 'Product successfully removed' }
      format.js
    end
  end


  private 
  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_item_params
    params.require(:line_item).permit(:product_id, :cart_id)
  end
end
