module CategoriesHelper
  def categories_for_select
    options = Category.ordered_by_name.map { |category| ["#{category.name} (#{category.slug})", category.id] }
    [[I18n.t(:not_selected), '']] + options
  end

  def link_to_shop_category(category, text = nil)
    link_to (text || category.name), shop_category_path(id: category.slug_for_url)
  end
end
