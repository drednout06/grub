class DishesController < ApplicationController
  # GET /dishes
  # GET /dishes.json
  def index
    @menu = Menu.find(params[:menu_id])
    @dishes = @menu.dishes

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
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dish }
    end
  end

  # GET /dishes/new
  # GET /dishes/new.json
  def new
    @menu = Menu.find(params[:menu_id])
    @dish = Dish.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dish }
    end
  end

  # GET /dishes/1/edit
  def edit
    @dish = Dish.find(params[:id])
  end

  # POST /dishes
  # POST /dishes.json
  def create
    @menu = Menu.find(params[:menu_id])
    @dish = @menu.dishes.build(params[:dish])

    respond_to do |format|
      if @dish.save
        flash[:notice] = 'Dish was successfully created.'
        format.html do
          if params[:dish][:picture].blank?
            redirect_to @dish
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
        flash[:notice] = 'Dish was successfully updated.'
        format.html do
          if params[:dish][:picture].blank?
            redirect_to @dish
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
    flash[:notice] = 'Dish was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to @menu }
      format.json { head :no_content }
    end
  end
end
