$(document).on 'click', '.btn-change-coin', (event) ->
  invert_coins()
  realiza_conversao()
  if  $("#result_bitcoin").val() != ''
    calc_bitcoin()
  return

$(document).on 'input', '#amount', (event) ->
  realiza_conversao()
  if  $("#result_bitcoin").val() != ''
    calc_bitcoin()
  return

$(document).on 'click', '.btn-convert-bitcoin', (event) ->
  calc_bitcoin()
  return

calc_bitcoin = () ->
  if  $("#amount").val() != ''
    url = 'https://blockchain.info/tobtc?currency='+ $('#source_currency').val() + '&value=' + $('#amount').val()
    $.ajax url,
        type: 'GET'
        dataType: 'json'
        error: (jqXHR, textStatus, errorThrown) ->
          alert textStatus
        success: (data, text, jqXHR) ->
          $('#result_bitcoin').val(data)
   else
     $('#result_bitcoin').val('')

invert_coins  = () ->
  moeda_pre = $('#target_currency').val()
  $('#target_currency').val($('#source_currency').val())
  $('#source_currency').val(moeda_pre)

realiza_conversao = () ->
  if  $("#amount").val() != ''
    $.ajax '/convert',
        type: 'GET'
        dataType: 'json'
        data: {
                source_currency: $("#source_currency").val(),
                target_currency: $("#target_currency").val(),
                amount: $("#amount").val()
              }
        error: (jqXHR, textStatus, errorThrown) ->
          alert textStatus
        success: (data, text, jqXHR) ->
          $('#result').val(data.value)
   else
     $('#result').val('')
     $('#result_bitcoin').val('')
