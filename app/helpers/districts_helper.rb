module DistrictsHelper

	def current_district
		cookies[:district_id]
	end

	def current_district_name
		District.find(current_district).try(:name)
	end

	def save_district(district_id)
		cookies.permanent[:district_id] = district_id || cookies[:district_id]
	end

	def delivery_fee(restaurant, district_id)
    fee = restaurant.delivery_fee(district_id)
    fee ? number_to_currency(fee) : t("navigation.no_delivery")
  end

end
