class ProductsController < ApplicationController
  layout 'products_layout'
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!


  def pundit_user
    current_account
  end

  # GET /products
  # GET /products.json
  def index
    if (params[:seller_id])
      @seller = Seller.find(params[:seller_id])
      @products = @seller.products
    else
      @products = Product.all
    end
    # This may be neater but it's causing problems.
    #authorize Product 
    #@products = policy_scope(Product)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    authorize @product
    @orders = @product.orders
  end

  # GET /products/new
  def new
    @product = Product.new
    authorize @product
  end

  # GET /products/1/edit
  def edit
    authorize @product
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    authorize @product
    @product.popularity = 0
    if current_account && current_account.accountable_type == "Seller"
      @product.seller = current_account.accountable
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    authorize @product
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
        
        @products = Product.all
        ActionCable.server.broadcast 'products',
          html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    authorize @product
    respond_to do |format|
      if @product.destroy    
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to products_url, notice: 'Product currently in a cart!' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :popularity)
    end
end
