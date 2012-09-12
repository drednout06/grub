# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('.menu .dish > img').click ->
		$(this).parent().find(':submit').click()
	$('.restaurant-list li').click ->
		window.location = $(this).find('a').attr('href')
