module OrderSession
  extend ActiveSupport::Concern

  protected

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
end
