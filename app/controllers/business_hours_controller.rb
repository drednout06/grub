class BusinessHoursController < InheritedResources::Base
	belongs_to :restaurant, optional: true
	load_and_authorize_resource

	def edit
		@weekdays = weekdays_for_select
		edit!
	end

	def update
		params[:business_hour][:day] = weekdays_for_select[params[:business_hour][:day]]
		params[:business_hour][:schedule] = build_schedule(params[:business_hour])
		update!{ restaurant_business_hours_path(@business_hour.restaurant) }
	end

	def new
		@weekdays = weekdays_for_select
		new!
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		params[:business_hour][:day] = weekdays_for_select[params[:business_hour][:day]]

		@business_hour = @restaurant.business_hours.build(params[:business_hour])
		
		schedule = build_schedule(params[:business_hour])
		@business_hour.schedule = schedule

		respond_to do |format|
      if @business_hour.save
        format.html { redirect_to(restaurant_business_hours_path(@restaurant), :notice => t('flash.created', model: BusinessHour.model_name.human)) }
        format.xml  { render :xml => @business_hour, :status => :created, :location => @business_hour }
      else
        @weekdays = weekdays_for_select.keys
        format.html { render :action => "new" }
        format.xml  { render :xml => @business_hour.errors, :status => :unprocessable_entity }
      end
    end
	end

	def build_schedule(params)
		regex = /^([01][0-9]|2[0-3]):[0-5][0-9]$/
		duration = 0
		if params[:opening] =~ regex and params[:closing] =~ regex
			o_hours = params[:opening][/^\d+/].to_i
			o_minutes = params[:opening][/\d+$/].to_i
			c_hours = params[:closing][/^\d+/].to_i
			c_minutes = params[:closing][/\d+$/].to_i
			duration = (c_hours * 60 + c_minutes) - (o_hours * 60 + o_minutes)
			if duration < 0 then duration += 24*60 end
			print "reached this point"
		else
			return
		end

    start_at = Time.zone.at(0)
		rule = IceCube::Rule.weekly
    rule.day(params[:day].to_sym)

    rule.hour_of_day(o_hours)
    rule.minute_of_hour(o_minutes)
    rule.second_of_minute(0)

    schedule = IceCube::Schedule.new(start_at, duration: duration * 60 + 59)
    schedule.add_recurrence_rule(rule)
    schedule
  end

  def index
  	@weekdays = weekdays_for_select
  	index!
  end

  def weekdays_for_select
  	{
  		t('date.day_names')[1] => 'monday',
  		t('date.day_names')[2] => 'tuesday',
  		t('date.day_names')[3] => 'wednesday',
  		t('date.day_names')[4] => 'thursday',
  		t('date.day_names')[5] => 'friday',
  		t('date.day_names')[6] => 'saturday',
  		t('date.day_names')[0] => 'sunday',
  	}
  end

end