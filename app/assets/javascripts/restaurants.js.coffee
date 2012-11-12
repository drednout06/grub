$ ->
	$('#restaurants .restaurant-row').click ->
		window.location = $(this).find('a').attr('href')

  $('.datepicker').datepicker()
