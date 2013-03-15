class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.order("created_at desc").page(params[:page]).per_page(10)

  end
  
  def new
  	@user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      custom_sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def show
    @user = User.find(params[:id])
    @addresses = @user.addresses
    @orders = @user.orders
  end

  def edit
    #render partial: 'devise/registrations/edit'
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      custom_sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def partner
    if user_signed_in?
      current_user.toggle!(:restaurateur)
      redirect_to restaurateur_user_path(current_user)
    else
      redirect_to new_user_registration_path(restaurateur: 1)
    end
  end

  def restaurateur
    if current_user.admin?
      @restaurants = Restaurant.all
    else
      @restaurants = current_user.restaurants
    end
  end

  # def report

  #   if current_user.admin?
  #     @restaurants = Restaurant.all
  #     @orders = Order.accepted
  #   else
  #     @restaurants = current_user.restaurants
  #     @orders = current_user.transactions
  #   end
  #   @user = User.find(params[:id])
  #   @start = params[:start].blank? ? 1.year.ago : Time.parse(params[:start]) 
  #   @finish = params[:finish].blank? ? Time.zone.now : Time.parse(params[:finish])

  # end

  def report
    if current_user.admin?
      @restaurants = Restaurant.all
      @orders = Order.accepted
    else
      @restaurants = current_user.restaurants
      @orders = current_user.transactions
    end
    @start = params[:start].blank? ? 1.year.ago : Time.parse(params[:start]) 
    @finish = params[:finish].blank? ? Time.zone.now : Time.parse(params[:finish])

  end

  private

    def signed_in_user
      unless user_signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless can? :update, @user
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
