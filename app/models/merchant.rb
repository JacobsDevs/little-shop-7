class Merchant < ApplicationRecord
	has_many :items

	def get_ready_to_ship_orders
		InvoicesItem.get_ready_to_ship(self.id)
	end
end