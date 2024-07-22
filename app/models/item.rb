class Item < ApplicationRecord
  enum status: {enabled: 0, disabled: 1}

	belongs_to :merchant
	has_many :invoices_items
	has_many :invoices, through: :invoices_items

end