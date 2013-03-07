jQuery ->
	$('#restaurants .restaurant-row').click ->
		unless $(event.target).is("a") or $(event.target).is("input")
			window.location = $(this).find('a').attr('href')

	$('td.timeago').timeago()
	$('.datepicker').datepicker()
	$('img.lazy').lazyload( effect : "fadeIn" )

  