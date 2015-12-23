class Shop::ItemsController < ApplicationController
  include OrderSession

  before_action :set_or_create_order, only: [:create, :destroy]

  def index
    @items = Item.page_for_shop current_page
  end

  def show
    @item = Item.find_by! visible: true, slug: params[:id]
  end

  def create
    item = Item.find params[:id].to_s.to_i
    @order.add_item item, quantity
    redirect_to item
  end

  def destroy
    item = Item.find params[:id].to_s.to_i
    @order.remove_item item
    redirect_to item
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
end
