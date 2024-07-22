class Item < ApplicationRecord
  enum status: {enabled: 0, disabled: 1}

	belongs_to :merchant
	has_many :invoices_items
	has_many :invoices, through: :invoices_items

  def change_status
    if self.enabled?
      self.update!(status: :disabled)
    else
      self.update!(status: :enabled)
    end
  end
end