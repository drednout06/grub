class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  before_filter :authenticate_user!

  def index
    @user = current_user
    @q = @user.orders.ransack(params[:q])
    @orders = @q.result(distinct: true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end


  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @user = current_user || User.new
    @address = @user.addresses.last
    new_address = @user.addresses.new(name: t('helpers.links.new'))
    @address ||= new_address

    @order = Order.new
    
    @cart = current_cart
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @address = @order.address
    @user = @order.user
  end

  def create
    @user = current_user
    @cart = current_cart

    params[:order][:status] = Order::STATUSES[:pending]
    address_params = params.delete(:address)
    address_params[:name] =
      "#{address_params[:first_name]} | #{address_params[:street]} #{address_params[:house]}"

    @order = @user.orders.new(params[:order])

    if params[:order][:address_id].blank?
      @address = @user.addresses.new(address_params)
      params[:result] = 'create failed'
      render action: "new" and return unless @address.save
      params[:order][:address_id] = @order.address_id = @address.id
    else
      @address = Address.find(params[:order][:address_id])
      params[:result] = 'update failed'
      render action: "new" and return unless @address.update_attributes(address_params)
    end

    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        params[:result] = 'order creation failed'
        format.html { render action: "new", notice: 'Save failed!' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_address
    @user = current_user
    @address = params[:address_id].blank? ? @user.addresses.build : Address.find(params[:address_id])
    respond_to do |format|
      format.js
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def accept
    @order = Order.find(params[:id])
    @order.update_attributes(status: Order::STATUSES[:accepted])
    respond_to do |format|
      format.js
    end
  end

  def reject
    @order = Order.find(params[:id])
    @order.update_attributes(status: Order::STATUSES[:rejected])
    respond_to do |format|
      format.js
    end
  end
end