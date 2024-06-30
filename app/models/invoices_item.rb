class InvoicesItem < ApplicationRecord
	enum :status, [:pending, :packaged, :shipped]
	belongs_to :invoice
	belongs_to :item

	def self.get_ready_to_ship(merchant_id)
		InvoicesItem.joins(item: :merchant)
		.where("invoices_items.status" => "packaged", "merchants.id" => merchant_id)
	end
end