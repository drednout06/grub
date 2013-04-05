jQuery ->
  
#  districts = $('#q_deliverabilities_district_id_in').html()
  #
#  city = $('#q_city_id_in :selected').text()
#  escaped_city = city.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
#  options = $(districts).filter("optgroup[label='#{escaped_city}']").html()
#  if options
#    $('#q_deliverabilities_district_id_in').html(options)
#  else
#    $('#q_deliverabilities_district_id_in').empty()
#
#  $('#q_city_id_in').change ->
#    city = $('#q_city_id_in :selected').text()
#    escaped_city = city.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
#    options = $(districts).filter("optgroup[label='#{escaped_city}']").html()
#    if options
#      $('#q_deliverabilities_district_id_in').html(options)
#      #$('#q_deliverabilities_district_id_in').parent().show()
#    else
#      $('#q_deliverabilities_district_id_in').empty()
#      #$('#q_deliverabilities_district_id_in').parent().hide()


  $('#q_deliverabilities_district_id_in').val(4)

  introJs().start()