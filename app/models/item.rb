class Item < ApplicationRecord
	belongs_to :merchant
	has_many :invoices_items
	has_many :invoices, through: :invoices_items
end