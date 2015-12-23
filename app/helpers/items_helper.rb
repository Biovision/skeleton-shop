module ItemsHelper

  def link_to_shop_item(item, text = nil)
    link_to (text || item.name), shop_item_path(id: item.slug)
  end
end
