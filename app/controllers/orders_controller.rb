class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  before_filter :auth_user

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
    @cart = current_cart
    unless @cart.enough?
      redirect_to :back, flash: {error: t('notice.sum_insufficient', value: @cart.remainder)}
      return
    end

    @user = current_user || User.new
    @address = @user.addresses.last
    new_address = @user.addresses.new(name: t('helpers.links.new'))
    @address ||= new_address
    @no_button = true
    @order = Order.new
    
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
    unless @cart.enough?
      redirect_to @cart.restaurant, flash: {error: t('notice.sum_insufficient', value: @cart.remainder)}
      return
    end

    params[:order][:status] = Order::STATUSES[:pending] # Refactor!
    address_params = params.delete(:address)
    address_params[:name] =
      "#{address_params[:first_name]} | #{address_params[:street]} #{address_params[:house]}"

    
    @order = @user.orders.new(params[:order])

    # Address form handling
    if params[:order][:address_id].blank?
      @address = @user.addresses.new(address_params)
      render action: "new" and return unless @address.save
      params[:order][:address_id] = @order.address_id = @address.id
    else
      @address = Address.find(params[:order][:address_id])
      render action: "new" and return unless @address.update_attributes(address_params)
    end

    @order.add_data_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to user_orders_path(@user), notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new", flash: {notice: 'Save failed!'} }
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

  def auth_user
    redirect_to new_user_registration_path unless user_signed_in?
  end
end