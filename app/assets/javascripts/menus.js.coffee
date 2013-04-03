# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#menus').sortable
    axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

jQuery ->
	$('tr.dish').click ->
		$.post($(this).data("link"), null, null, "script")