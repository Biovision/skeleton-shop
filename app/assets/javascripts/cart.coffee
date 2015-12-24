$(document).ready ->
  update_cart_data = (data) ->
    cart = $('#cart')
    cart.find('div.item_count').html(data['item_count'])
    cart.find('div.price').html(data['price'])

  $('div.cart-control > button').on 'click', ->
    url = $(this).data('url')
    item_id = $(this).data('id')
    $.post url,
      id: item_id,
      (data) ->
        update_cart_data data['order'] if data['order']

