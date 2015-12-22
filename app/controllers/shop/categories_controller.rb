class Shop::CategoriesController < ApplicationController
  def index
    @categories = Category.level(nil, true)
  end

  def show
    @category = Category.find_by! slug: params[:id], visible: true
  end
end
