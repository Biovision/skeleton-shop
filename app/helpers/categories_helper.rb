module CategoriesHelper
  def categories_for_select
    options = Category.ordered_by_name.map { |category| ["#{category.name} (#{category.slug})", category.id] }
    [[I18n.t(:not_selected), '']] + options
  end
end
