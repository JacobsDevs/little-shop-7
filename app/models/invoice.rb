class Invoice < ApplicationRecord
	belongs_to :customer
	has_many :transactions
	has_many :invoices_items
	has_many :items, through: :invoices_items
	enum :status, [:in_progress, :completed, :cancelled]

	def self.get_successful_transaction_count_for_merchant(customer_id, merchant_id)
		Invoice.joins([:customer ,{invoices_items: {item: :merchant}}, :transactions])
		.where("transactions.result" => "success", "customers.id" => customer_id, "merchants.id" => merchant_id)
		.distinct
		.count
	end

  def is_successful?
    if transactions.where("result" => "success").count > 0
      return true
    else
      return false
    end
  end
end