class Shop::ItemsController < ApplicationController
  include OrderSession

  before_action :set_or_create_order, only: [:create, :destroy]

  def index
    @items = Item.page_for_shop current_page
  end

  def show
    @item = Item.find_by! visible: true, slug: params[:id]
  end

  # post /cart/items/:id
  def create
    item = Item.find params[:id].to_s.to_i
    @order.add_item item, quantity
    respond_to do |format|
      format.any(:json, :js) { render json: order_data }
      format.html { redirect_to item }
    end
  end

  # delete /cart/item/:id
  def destroy
    item = Item.find params[:id].to_s.to_i
    @order.remove_item item
    respond_to do |format|
      format.any(:json, :js) { render json: order_data }
      format.html { redirect_to item }
    end
  end

  private

  def set_or_create_order
    set_order
    create_order unless @order.is_a? Order
  end

  def quantity
    if params[:quantity].nil?
      1
    else
      quantity = params[:quantity].to_s.to_i
      ((1..100) === quantity) ? quantity : 1
    end
  end

  def order_data
    { order: { price: @order.price, item_count: t(:item, count: @order.item_count) } }
  end
end
