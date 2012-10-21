class CuisinesController < InheritedResources::Base

	def index
		@cuisines = Cuisine.all
		index!
	end

	def sort
    params[:cuisine].each_with_index do |id, index|
      Cuisine.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
end
