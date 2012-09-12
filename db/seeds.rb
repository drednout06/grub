# encoding: utf-8

cities = [ {
		name: { kk: 'Алматы', ru: 'Алматы'},

		districts: [
			{ kk: 'Алмалы', ru: 'Алмалинский'},
			{ kk: 'Алатау', ru: 'Алатауский'},
			{ kk: 'Әуезов', ru: 'Ауэзовский'},
			{ kk: 'Бостандық', ru: 'Бостандыкский'},
			{ kk: 'Жетiсу', ru: 'Жетысуский'},
			{ kk: 'Медеу', ru: 'Медеуский'},
			{ kk: 'Түрксіб', ru: 'Турксибский'}
		]
	}]

cities.each_index do |i|
	I18n.locale = 'kk'
	city = City.find_or_create_by_name(cities[i][:name][:kk])
	I18n.locale = 'ru'
	city.name = cities[i][:name][:ru]
	city.save

	cities[i][:districts].each_index do |j|
		I18n.locale = 'kk'
		district = city.districts.find_or_create_by_name(cities[i][:districts][j][:kk])
		I18n.locale = 'ru'
		district.name = cities[i][:districts][j][:ru]
		district.save
	end
end
