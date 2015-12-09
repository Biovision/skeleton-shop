class Shop::CartsController < ApplicationController
  include OrderSession

  before_action :set_order

  def show
    create_order unless @order.is_a? Order
  end

  def edit
    create_order unless @order.is_a? Order
  end

  def update
    if @order.is_a? Order
      place_order
    else
      create_order
      redirect_to shop_cart_path
    end
  end

  def destroy
    if @order.is_a? Order
      @order.update state: Order.states[:rejected]
    end
    session[:order_id] = nil
    redirect_to root_path, notice: t('carts.destroy.success')
  end

  private

  def order_parameters
    params.require(:order).permit(:name, :phone, :email, :address, :comment)
  end

  def place_order
    if @order.update order_parameters.merge(state: Order.states[:placed])
      session[:order_id] = nil
      redirect_to root_path, notice: t('carts.update.success')
    else
      render :edit
    end
  end
end
