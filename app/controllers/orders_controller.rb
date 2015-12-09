class OrdersController < ApplicationController
  before_action :restrict_access
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  def index
    @collection = Order.page_for_administrator current_page
  end

  def show
  end

  def edit
  end

  def update
    if @entity.update entity_parameters
      redirect_to @entity, notice: t('orders.update.success')
    else
      render :edit
    end
  end

  def destroy
    if @entity.destroy
      flash[:notice] = t('orders.delete.success')
    end
    redirect_to orders_path
  end

  protected

  def restrict_access
    require_role :administrator
  end

  def set_entity
    @entity = Order.find params[:id]
  end

  def entity_parameters
    params.require(:order).permit(:state)
  end
end
