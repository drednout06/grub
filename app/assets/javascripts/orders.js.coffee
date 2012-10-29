jQuery ->
  $('#order_address_id').change ->
    $.get '/orders/update_address', address_id: $('#order_address_id :selected').val()
  now = new Date()
  tomorrow = new Date(now.getTime() + (24 * 60 * 60 * 1000))
  $('.datetimepicker').datetimepicker({minDateTime: now, maxDateTime: tomorrow})
  $('#order_deliver_now').click ->
    $('#order_delivery_time').prop('disabled', $(this).is(':checked'))