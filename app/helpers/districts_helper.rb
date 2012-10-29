module DistrictsHelper

	def current_district
		cookies[:district_id]
	end

	def save_district(district_id)
		cookies.permanent[:district_id] = district_id || cookies[:district_id]
	end

end
