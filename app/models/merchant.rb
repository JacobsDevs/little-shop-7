class Merchant < ApplicationRecord
	has_many :items

	def get_ready_to_ship_orders
		InvoicesItem.get_ready_to_ship(self.id)
	end

  def get_items_by_revenue
    items.sort_by(&:get_item_revenue_int).reverse
  end
end