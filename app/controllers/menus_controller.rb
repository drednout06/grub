class MenusController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb I18n.t('layouts.header.home'), :root_path
  
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menus = @restaurant.menus

    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
    add_breadcrumb I18n.t('layouts.header.restaurateur'), restaurateur_user_path(current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu = Menu.find(params[:id])
    @restaurant = @menu.restaurant

    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
    add_breadcrumb I18n.t('layouts.header.restaurateur'), restaurateur_user_path(current_user)
    add_breadcrumb Menu.model_name.human.mb_chars.capitalize, restaurant_menus_path(@restaurant)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.new

    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
    add_breadcrumb I18n.t('layouts.header.restaurateur'), restaurateur_user_path(current_user)
    add_breadcrumb Menu.model_name.human.mb_chars.capitalize, restaurant_menus_path(@restaurant)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.find(params[:id])

    add_breadcrumb @menu.restaurant.name, restaurant_path(@menu.restaurant)
    add_breadcrumb I18n.t('layouts.header.restaurateur'), restaurateur_user_path(current_user)
    add_breadcrumb Menu.model_name.human.mb_chars.capitalize, restaurant_menus_path(@menu.restaurant)
  end

  # POST /menus
  # POST /menus.json
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = @restaurant.menus.build(params[:menu])

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: t('flash.created', model: Menu.model_name.human) }
        format.json { render json: @menu, status: :created, location: @menu }
      else
        format.html { render action: "new" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @menu = Menu.find(params[:id])
    @restaurant = @menu.restaurant

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to @menu, notice: t('flash.updated', model: Menu.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu = Menu.find(params[:id])
    @restaurant = @menu.restaurant
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to restaurant_menus_url(@restaurant) }
      format.json { head :no_content }
    end
  end

  def sort
    params[:menu].each_with_index do |id, index|
      Menu.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
end
