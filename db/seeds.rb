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
			{ kk: 'Түрксіб', ru: 'Турксибский'},
			{ kk: 'Боралдай', ru: 'Турксибский'}
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



cuisines = [
	{ ru: 'Халяль', kk: 'Халал'},
	{ ru: 'Пицца', kk: 'Пицца'},
	{ ru: 'Суши', kk: 'Суши'},
	{ ru: 'Пироги', kk: 'Пирогтар'},
	{ ru: 'Шашлык', kk: 'Кәуап'},
	{ ru: 'Пиво', kk: 'Сыра'},
 	{ ru: 'Фаст фуд', kk: 'Фаст фуд'},
	{ ru: 'Итальянская', kk: 'Итальян'},
	{ ru: 'Японская', kk: 'Жапон'},
	{ ru: 'Азиатская', kk: 'Азиялық'},
	{ ru: 'Американская', kk: 'Америкалық'},
	{ ru: 'Ближневосточная', kk: 'Таяу шығыс'},
	{ ru: 'Бургеры', kk: 'Бургерлер'},
	{ ru: 'Вегетарианская', kk: 'Вегетариандық'},
	{ ru: 'Грузинская', kk: 'Грузин'},
	{ ru: 'Домашняя', kk: 'Үй'},
	{ ru: 'Европейская', kk: 'Еуропалық'},
	{ ru: 'Индийская', kk: 'Үнді'},
	{ ru: 'Кавказская', kk: 'Кавказ'},
	{ ru: 'Китайская', kk: 'Қытай'},
	{ ru: 'Кондитерские изделия', kk: 'Кондитер бұйымдары'},
	{ ru: 'Корейская', kk: 'Кәріс'},
	{ ru: 'Питьевая вода', kk: 'Су'},
	{ ru: 'Русская', kk: 'Орыс'},
	{ ru: 'Рыбная', kk: 'Балық'},
	{ ru: 'Тайская', kk: 'Тай'},
	{ ru: 'Турецкая', kk: 'Түрік'},
	{ ru: 'Узбекская', kk: 'Өзбек'},
	{ ru: 'Украинская', kk: 'Украин'},
	{ ru: 'Французская', kk: 'Француз'},
	{ ru: 'Средиземноморская', kk: 'Жерорта теңіздік'},
]

cuisines.each_index do |i|
	I18n.locale = 'kk'
	cuisine = Cuisine.find_or_create_by_name(cuisines[i][:kk])
	I18n.locale = 'ru'
	cuisine.name = cuisines[i][:ru]
	cuisine.save
end