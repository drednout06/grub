class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

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
    @order = Order.new
    @user = current_user || User.new
    @address = @user.address || Address.new
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

  # POST /orders
  # POST /orders.json
  # TO-DO: REFACTOR!
  def create
    @user = current_user
    @cart = current_cart
    @address = @user.address if !@user.nil?
    if signed_in?
      if @address and !@address.new_record?
        @address.update_attributes(params[:address])
      else
        user_params = {name: "#{params[:address][:first_name]} - #{params[:address][:street]}"}
        @address = @user.addresses.new(params[:address].merge(user_params))
        @user.update_attributes({address_id: @address.id}) if @address.save
      end
    else
      @user = User.new(params[:user])
      if @user.save
        custom_sign_in @user
        user_params = {first_name: @user.first_name, last_name: @user.last_name,
                        phone: @user.phone, name: "#{@user.first_name} - #{params[:address][:street]}"}
        @address = @user.addresses.new(params[:address].merge(user_params))
        @user.update_attributes({address_id: @address.id}) if @address.save
      else
        @address = Address.new(params[:address])
        @order = Order.new(params[:order])
        render action: "new"
        return
      end

    end
    
    @order = @user.orders.new(params[:order].merge({address_id: @address.id}))
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @user.id and @address.id and @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
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
end
