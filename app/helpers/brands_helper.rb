module BrandsHelper
  def brands_for_select
    options = Brand.ordered_by_name.map { |brand| [brand.name, brand.id] }
    [[I18n.t(:not_selected), '']] + options
  end
end
