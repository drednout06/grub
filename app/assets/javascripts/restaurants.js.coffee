$ ->
	$('#restaurants .restaurant-row').click ->
		unless $(event.target).is("a") or $(event.target).is("input")
			window.location = $(this).find('a').attr('href')


  $('.datepicker').datepicker()