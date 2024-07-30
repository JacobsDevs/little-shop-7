include ActiveSupport::NumberHelper

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

  def get_successful_invoice_items
    a = invoices_items.map {|i| i if i.invoice.is_successful?}
    a.compact
  end

  def get_item_revenue_int
    revenue = get_successful_invoice_items.sum {|i| i.unit_price * i.quantity.to_i}
  end

  def get_item_revenue_formatted
    revenue = get_successful_invoice_items.sum {|i| i.unit_price * i.quantity.to_i}
    number_to_currency(revenue)
  end

  def get_best_day
    a = invoices_items.group_by(&:get_create_date)
    b = a.map {|k, v| [k, number_to_currency(v.sum {|i| i.unit_price * i.quantity.to_i})]}.to_h
    b.max_by {|k, v| v}
  end
end