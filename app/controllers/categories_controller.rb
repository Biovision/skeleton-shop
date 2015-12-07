class CategoriesController < ApplicationController
  before_action :restrict_access
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  def index
    @collection = Category.page_for_administrator current_page
  end

  def new
    @entity = Category.new
  end

  def create
    @entity = Category.new entity_parameters
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
      redirect_to @entity, notice: t('categories.update.success')
    else
      render :edit
    end
  end

  def destroy
    if @entity.destroy
      flash[:notice] = t('categories.delete.success')
    end
    redirect_to categories_path
  end

  protected

  def restrict_access
    require_role :administrator
  end

  def set_entity
    @entity = Category.find params[:id]
  end

  def entity_parameters
    params.require(:category).permit(Category.entity_parameters)
  end
end
