$(document).ready ->
  $('div.cart-control > button').on 'click', ->
    url = $(this).data('url')
    item_id = $(this).data('id')
    $.post url,
      id: item_id,
      (data) ->
        console.log data

