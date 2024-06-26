class InvoicesItem < ApplicationRecord
	belongs_to :invoice
	belongs_to :item

	enum :status, [:pending, :packaged, :shipped]
end