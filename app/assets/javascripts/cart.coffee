$(document).ready ->
  update_cart_data = (data) ->
    cart = $('#cart')
    cart.find('div.item_count').html(data['item_count'])
    cart.find('div.price').html(data['price'])
    shop_total = $('#cart-total')
    if shop_total
      shop_total.find('.item_count').html data['item_count']
      shop_total.find('.price').html data['price']

  change_item_count = (counter, delta) ->
    old_value = parseInt counter.html()
    new_value = old_value + delta
    if new_value < 1
      counter.closest('li').hide()
    else
      counter.html new_value

  $('div.cart-control > button').on 'click', ->
    url = $(this).data 'url'
    item_id = $(this).data 'id'
    $.post url,
      id: item_id,
      (data) ->
        update_cart_data data['order'] if data['order']

  $('div.quantity-manager > .increment').on 'click', ->
    url = $(this).data 'url'
    item_id = $(this).parent().data 'id'
    counter = $(this).parent().find '.count'
    $.post url,
      id: item_id,
      (data) ->
        if data['order']
          update_cart_data data['order']
          change_item_count counter, 1

  $('div.quantity-manager > .decrement').on 'click', ->
    url = $(this).data 'url'
    counter = $(this).parent().find '.count'
    $.ajax url,
      method: 'DELETE',
      success: (data) ->
        if data['order']
          update_cart_data data['order']
          change_item_count counter, -1
