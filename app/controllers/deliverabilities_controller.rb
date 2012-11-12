class DeliverabilitiesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @deliverabilities = @restaurant.deliverabilities

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deliverabilities }
    end
  end

  # GET /deliverabilities/1
  # GET /deliverabilities/1.json
  def show
    @deliverability = Deliverability.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deliverability }
    end
  end

  # GET /deliverabilities/new
  # GET /deliverabilities/new.json
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @deliverability = Deliverability.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deliverability }
    end
  end

  # GET /deliverabilities/1/edit
  def edit
    @deliverability = Deliverability.find(params[:id])
  end

  # POST /deliverabilities
  # POST /deliverabilities.json
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @deliverability = @restaurant.deliverabilities.build(params[:deliverability])

    respond_to do |format|
      if @deliverability.save
        format.html { redirect_to restaurant_deliverabilities_path(@restaurant), notice: 'Deliverability was successfully created.' }
        format.json { render json: @deliverability, status: :created, location: @deliverability }
      else
        format.html { render action: "new" }
        format.json { render json: @deliverability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deliverabilities/1
  # PUT /deliverabilities/1.json
  def update
    @deliverability = Deliverability.find(params[:id])

    respond_to do |format|
      if @deliverability.update_attributes(params[:deliverability])
        format.html { redirect_to restaurant_deliverabilities_path(@deliverability.restaurant),
           notice: 'Deliverability was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deliverability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliverabilities/1
  # DELETE /deliverabilities/1.json
  def destroy
    @deliverability = Deliverability.find(params[:id])
    @deliverability.destroy

    respond_to do |format|
      format.html { redirect_to deliverabilities_url }
      format.json { head :no_content }
    end
  end
end
