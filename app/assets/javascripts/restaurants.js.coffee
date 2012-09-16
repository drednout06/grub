

$ ->
	$('.menu .dish > img').click ->
		$(this).parent().find(':submit').click()
	$('.restaurant-list li').click ->
		window.location = $(this).find('a').attr('href')