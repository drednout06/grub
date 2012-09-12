jQuery ->
  $('#order_address_id').change ->
    $.get '/orders/update_address', address_id: $('#order_address_id :selected').val()
