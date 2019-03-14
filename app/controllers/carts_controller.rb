class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  include CurrentCart
  before_action :set_cart
  before_action :check_cart
  before_action :authenticate_account!
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart


  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    respond_to do |format|
      format.json {}
      format.html
    end
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to store_index_url,
                    notice: 'Your cart is currently empty' }
      #look for app/views/carts/destroy.js.erb (ajax empty cart btn)
      format.js
      format.json {}
    end
  end


  private
  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to store_index_url, notice: 'Invalid cart'
  end

  def check_cart 
    #@cart = Cart.find(params[:id])
    if @cart.id != session[:cart_id]
      invalid_cart
    end
  end

  def cart_params
    params.fetch(:cart, {})
  end
end
