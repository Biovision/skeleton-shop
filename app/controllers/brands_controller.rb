class BrandsController < ApplicationController
  before_action :restrict_access
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  def index
    @collection = Brand.page_for_administrator current_page
  end

  def new
    @entity = Brand.new
  end

  def create
    @entity = Brand.new entity_parameters
    if @entity.save
      redirect_to @entity
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @entity.update entity_parameters
      redirect_to @entity, notice: t('brands.update.success')
    else
      render :edit
    end
  end

  def destroy
    if @entity.destroy
      flash[:notice] = t('brands.delete.success')
    end
    redirect_to brands_path
  end

  protected

  def restrict_access
    require_role :administrator
  end

  def set_entity
    @entity = Brand.find params[:id]
  end

  def entity_parameters
    params.require(:brand).permit(Brand.entity_parameters)
  end
end
