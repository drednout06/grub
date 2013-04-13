class RestaurantsController < ApplicationController
  after_filter :update_rating, only: :rate
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]
  load_and_authorize_resource :user
  load_and_authorize_resource :restaurant, through: :user, shallow: true

  # GET /restaurants
  # GET /restaurants.json
  def index
    @q = Restaurant.enabled.ransack(params[:q])
    @restaurants = @q.result(:distinct => true).sort_by{|r| [r.open? ? 0 : 1, r.rating * -1] } # refactor!
    @q.build_sort if @q.sorts.empty?

    save_district params[:q].try(:[], :deliverabilities_district_id_in)
  end

  def search
    index
    render :index
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews
    @cart = current_cart || create_cart_for(@restaurant)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurant }
    end
  end

  # GET /restaurants/new
  # GET /restaurants/new.json
  def new
    @user = User.find(params[:user_id])
    @restaurant = Restaurant.new

    add_breadcrumb I18n.t('layouts.header.home'), :root_path
    add_breadcrumb I18n.t('layouts.header.restaurateur'), restaurateur_user_path(current_user)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @restaurant }
    end
  end

  # GET /restaurants/1/edit
  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @user = User.find(params[:user_id])
    @restaurant = @user.restaurants.build(params[:restaurant])
    #@restaurant = Restaurant.new(params[:restaurant])
    respond_to do |format|
      if @restaurant.save
        flash[:notice] = t('flash.created', model: Restaurant.model_name.human)
        format.html do
          if params[:restaurant][:logo].blank?
            redirect_to @restaurant
          else
            render action: 'crop'
          end
        end
        format.json { render json: @restaurant, status: :created, location: @restaurant }
      else
        format.html { render action: "new" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.json
  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        flash[:notice] = t('flash.updated', model: Restaurant.model_name.human)
        format.html do
          if params[:restaurant][:logo].blank?
            redirect_to @restaurant
          else
            render action: 'crop'
          end
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end

  def operate
    @restaurant = Restaurant.find(params[:id])
    @q = @restaurant.orders.ransack(params[:q])

    @orders = @q.result(distinct: true).page(params[:page]).per_page(10)
    @most_recent = @orders.first
  end

  def rate
    value = params[:rating].to_i
    @restaurant = Restaurant.find(params[:id])
    @restaurant.add_or_update_evaluation(:rating, value, current_user)
    respond_to do |format|
      format.js
    end
  end

  def get_orders
    @orders = Order.where("restaurant_id = ? and created_at > ?",
      params[:id], Time.at(params[:after].to_i + 1)).order("created_at DESC");

    respond_to do |format|
      format.js
    end
  end

  def stats
    @restaurant = Restaurant.find(params[:id])
    @start = Time.parse(params[:start]) unless params[:start].blank?
    @finish = Time.parse(params[:finish]) unless params[:start].blank?
  end

  private
    
    def update_rating
      @restaurant.update_attributes(rating: @restaurant.reputation_value_for(:rating))
      print 'hi from update_rating'
    end
end
