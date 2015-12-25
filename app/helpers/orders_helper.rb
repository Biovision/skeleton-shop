module OrdersHelper
  def order_states_for_select
    Order.states.keys.map { |state| [I18n.t("activerecord.attributes.order.states.#{state}"), state] }
  end
end
