class Customer < ApplicationRecord
	has_many :invoices

	def self.get_most_transactions(merchant_id, limit = 5)
		Customer.joins(invoices: [{invoices_items: {item: :merchant}}, :transactions])
		.where("transactions.result" => "success", "merchant.id" => merchant_id)
		.select('customers.*, COUNT(transactions.*) as transaction_count')
		.group('customers.id')
		.order('transaction_count desc')
		.limit(limit)
	end

	def self.build_top_five_customers_hash(merchant_id)
		top_five_customer_records = Customer.get_most_transactions(merchant_id)
		top_customer_names_array = top_five_customer_records.map {|c| "#{c.first_name} #{c.last_name}"}
		successful_transactions = get_customers_successful_transactions(top_five_customer_records, merchant_id)
		top_customer_names_array.zip(successful_transactions).to_h

	end

	def self.get_customers_successful_transactions(customer_records, merchant_id)
		successful_transactions = []
		customer_records.each do |c|
			successful_transactions.append(Invoice.get_successful_transaction_count_for_merchant(c.id, merchant_id))
		end
		return successful_transactions
	end
end