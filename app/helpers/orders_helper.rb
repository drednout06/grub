module OrdersHelper
	def conversions_chart_data(restaurant, start, finish)
    start ||= 2.weeks.ago
    finish ||= Time.zone.now
		orders_by_day = restaurant.orders_count_by_day(start, finish)
		views_by_day = restaurant.views_count_by_day(start, finish)
		(start.to_date..finish.to_date).map do |date|
      {
        created_at: date,
        order: orders_by_day[date] || 0,
        view: views_by_day[date] || 0
      }
    end
	end

  def revenues_chart_data(restaurant, start, finish)
    start ||= 2.weeks.ago
    finish ||= Time.zone.now
    revenues_by_day = restaurant.revenues_by_day(start, finish)
    (start.to_date..finish.to_date).map do |date|
      {
        created_at: date,
        revenue: revenues_by_day[date] || 0
      }
    end
  end
end
