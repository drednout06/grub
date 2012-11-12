ActiveAdmin.register Restaurant do

  index do
    column :title
    column :name
    column :minimum_order
    column :created_at
    column :enabled
    default_actions
  end

  show do
  	panel "Districts" do
  		table_for restaurant.deliverabilities do
  			column "district" do |deliverability|
  				deliverability.district.name
  			end
  			column :fee
  		end
  	end
  end

  form do |f|
	  f.inputs "Details" do
	    f.input :name
      f.input :enabled
	  end

	  f.inputs "Deliverabilities" do
		  f.has_many :deliverabilities do |del_f|
	      if !del_f.object.nil?
	        # show the destroy checkbox only if it is an existing appointment
	        # else, there's already dynamic JS to add / remove new districts
	        del_f.input :_destroy, :as => :boolean, :label => "Destroy?"
	      end

	      del_f.input :district # it should automatically generate a drop-down select to choose from your existing patients
	      del_f.input :fee
        del_f.buttons
		  end

		end
    f.buttons
	end
end
