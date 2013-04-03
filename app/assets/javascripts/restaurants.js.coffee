jQuery ->
	$('#restaurants .restaurant-row').click ->
		unless $(event.target).is("a") or $(event.target).is("input")
			window.location = $(this).data("link")

	$('td.timeago').timeago()
	$('.datepicker').datepicker()
	$('img.lazy').lazyload( effect : "fadeIn" )

  