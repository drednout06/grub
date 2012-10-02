$ ->
	$('.restaurant-list li').click ->
		window.location = $(this).find('a').attr('href')
