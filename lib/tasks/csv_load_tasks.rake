require 'csv'

desc "loads csv's to seed the db"
namespace :csv_load do
	desc "load all csv's in the /db/data"
	task all: [:invoices_items, :transactions]  do

	end
	
	desc "load all customers from /db/data/customers.csv"
	task customers: [:environment] do
		csv = CSV.parse(File.read("db/data/customers.csv"), headers: true)
		if csv.size != Customer.count
			csv.each do |customer|
				if Customer.all.empty? || Customer.where(id: customer['id']).empty?
					Customer.create!(
						first_name: customer['first_name'],
						last_name: customer['last_name'],
						created_at: customer['created_at'],
						updated_at: customer['updated_at'])
				end
			end
		end
	end
	
	desc "load all invoice_items from /db/data/invoice_items.csv"
	task invoices: [:environment, :customers] do
		csv = CSV.parse(File.read("db/data/invoices.csv"), headers: true)
		if csv.size != Invoice.count
			csv.each do |invoice|
				if Invoice.all.empty? || Invoice.where(id: invoice['id']).empty?
					Invoice.create!(
						customer_id: invoice['customer_id'],
						status: invoice['status'],
						created_at: invoice['created_at'],
						updated_at: invoice['updated_at'])
				end
			end
		end
	end
	
	desc "load all invoice_items from /db/data/invoice_items.csv"
	task items: [:environment, :merchants] do
		csv = CSV.parse(File.read("db/data/items.csv"), headers: true)
		if csv.size != Item.count
			csv.each do |item|
				if Item.all.empty? || Item.where(id: item['id']).empty?
					Item.create!(
						name: item['name'],
						description: item['description'],
						unit_price: item['unit_price'],
						merchant_id: item['merchant_id'],
						created_at: item['created_at'],
						updated_at: item['updated_at'])
				end
			end
		end
	end

	desc "load all invoice_items from /db/data/invoice_items.csv"
	task merchants: [:environment] do
		csv = CSV.parse(File.read("db/data/merchants.csv"), headers: true)
		if csv.size != Merchant.count
			csv.each do |merchant|
				if Merchant.all.empty? || Merchant.where(id: merchant['id']).empty?
					Merchant.create!(
						name: merchant['name'],
						created_at: merchant['created_at'],
						updated_at: merchant['updated_at'])
				end
			end
		end
	end

	desc "load all invoice_items from /db/data/invoice_items.csv"
	task transactions: [:environment, :invoices] do
		csv = CSV.parse(File.read("db/data/transactions.csv"), headers: true)
		if csv.size != Transaction.count
			csv.each do |transaction|
				if Transaction.all.empty? || Transaction.where(id: transaction['id']).empty?
					Transaction.create!(
						invoice_id: transaction['invoice_id'],
						credit_card_number: transaction['credit_card_number'],
						credit_card_expiration_date: transaction['credit_card_expiration_date'],
						result: transaction['result'],
						created_at: transaction['created_at'],
						updated_at: transaction['updated_at']
						)
				end
			end
		end
	end

	desc "load all invoice_items from /db/data/invoice_items.csv"
	task invoices_items: [:environment, :invoices, :items] do
		csv = CSV.parse(File.read("db/data/invoice_items.csv"), headers: true)
		if csv.size != InvoicesItem.count
			csv.each do |invoice_item|
				if InvoicesItem.all.empty? || InvoicesItem.where(id: invoice_item['id']).empty?
					InvoicesItem.create!(
						item_id: invoice_item['item_id'],
						invoice_id: invoice_item['invoice_id'],
						quantity: invoice_item['quantity'],
						unit_price: invoice_item['unit_price'],
						status: invoice_item['status'],
						created_at: invoice_item['created_at'],
						updated_at: invoice_item['updated_at']
						)
				end
			end
		end
	end
end