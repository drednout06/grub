class DishesController < ApplicationController
  load_and_authorize_resource :menu
  load_and_authorize_resource :dish, through: :menu, shallow: true
  add_breadcrumb I18n.t('layouts.header.home'), :root_path
  
  def index
    @menu = Menu.find(params[:menu_id])
    @dishes = @menu.dishes
    @restaurant = @menu.restaurant

    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
    add_breadcrumb I18n.t('layouts.header.restaurateur'), restaurateur_user_path(current_user)
    add_breadcrumb Menu.model_name.human.mb_chars.capitalize, restaurant_menus_path(@restaurant)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dishes }
    end
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
    @dish = Dish.find(params[:id])
    @menu = @dish.menu
    @restaurant = @menu.restaurant

    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
    add_breadcrumb I18n.t('layouts.header.restaurateur'), restaurateur_user_path(current_user)
    add_breadcrumb Menu.model_name.human.mb_chars.capitalize, restaurant_menus_path(@restaurant)
    add_breadcrumb @menu.name, menu_dishes_path(@menu)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dish }
    end
  end

  # GET /dishes/new
  # GET /dishes/new.json
  def new
    @menu = Menu.find(params[:menu_id])
    @dish = @menu.dishes.build

    @restaurant = @menu.restaurant

    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
    add_breadcrumb I18n.t('layouts.header.restaurateur'), restaurateur_user_path(current_user)
    add_breadcrumb Menu.model_name.human.mb_chars.capitalize, restaurant_menus_path(@restaurant)
    add_breadcrumb @menu.name, menu_path(@menu)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dish }
    end
  end

  # GET /dishes/1/edit
  def edit
    @dish = Dish.find(params[:id])

    @restaurant = @dish.restaurant

    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
    add_breadcrumb I18n.t('layouts.header.restaurateur'), restaurateur_user_path(current_user)
    add_breadcrumb Menu.model_name.human.mb_chars.capitalize, restaurant_menus_path(@restaurant)
    add_breadcrumb @dish.menu.name, menu_dishes_path(@dish.menu)
  end

  # POST /dishes
  # POST /dishes.json
  def create
    @menu = Menu.find(params[:menu_id])
    @dish = @menu.dishes.build(params[:dish])

    respond_to do |format|
      if @dish.save
        flash[:notice] = t('flash.created', model: Dish.model_name.human)
        format.html do
          if params[:dish][:picture].blank?
            redirect_to menu_dishes_path(@menu)
          else
            render action: 'crop'
          end
        end
        format.json { render json: @dish, status: :created, location: @dish }
      else
        format.html { render action: "new" }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dishes/1
  # PUT /dishes/1.json
  def update
    @dish = Dish.find(params[:id])
    @menu = @dish.menu

    respond_to do |format|
      if @dish.update_attributes(params[:dish])
        flash[:notice] = t('flash.updated', model: Dish.model_name.human)
        format.html do
          if params[:dish][:picture].blank?
            redirect_to menu_dishes_path(@menu)
          else
            render action: 'crop'
          end
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    @dish = Dish.find(params[:id])
    @menu = @dish.menu
    @dish.destroy
    flash[:notice] = t('flash.destroyed', model: Dish.model_name.human)
    respond_to do |format|
      format.html { redirect_to @menu }
      format.json { head :no_content }
    end
  end

  def sort
    params[:dish].each_with_index do |id, index|
      Dish.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
end
