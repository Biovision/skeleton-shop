class Shop::CartsController < ApplicationController
  before_action :set_order

  def show
    create_order unless @order.is_a? Order
  end

  def edit
    create_order unless @order.is_a? Order
  end

  def update
    if @order.is_a? Order

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

  def set_order
    if session[:order_id]
      @order = Order.find_by id: session[:order_id]
    else
      @order = nil
    end
  end

  def create_order
    @order = Order.create
    session[:order_id] = @order.id
  end

  def order_parameters
    params.require(:order).permit(:name, :phone, :email, :address, :comment)
  end
end
