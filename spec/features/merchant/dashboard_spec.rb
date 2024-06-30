require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
	it 'Exists' do		
		visit "/merchants/1/dashboard"
	end

	it 'shows the merchant\'s name' do
		visit "/merchants/1/dashboard"

		expect(page).to have_content("#{Merchant.first.name}")
	end

	it 'has links to my items and my invoices indexes' do
		visit "/merchants/1/dashboard"

		expect(page).to have_link(nil, href: "/merchants/1/items")
		expect(page).to have_link(nil, href: "/merchants/1/invoices")
	end

	it 'has Favorite Customers' do
		top_five = Customer.build_top_five_customers_hash(1)
		
		visit "/merchants/1/dashboard"
		
		expect(page).to have_content("Top 5 Customers")

		expect(page).to have_content("#{top_five.keys[0]} - #{top_five.values[0]} purchase")
		expect(page).to have_content("#{top_five.keys[1]} - #{top_five.values[1]} purchase")
		expect(page).to have_content("#{top_five.keys[2]} - #{top_five.values[2]} purchase")
		expect(page).to have_content("#{top_five.keys[3]} - #{top_five.values[3]} purchase")
		expect(page).to have_content("#{top_five.keys[4]} - #{top_five.values[4]} purchase")
	end

	before(:each) do
		@merchant = Merchant.create!
		item = @merchant.items.create!(name: "Bob's Big Bandaids")
		@customer_1 = Customer.create!(first_name: "Secondbest", last_name: "Customer")
		@customer_2 = Customer.create!(first_name: "Best", last_name: "Customer")
		@customer_3 = Customer.create!(first_name: "Worst", last_name: "Customer")

		inv_1_1 = @customer_1.invoices.create!
		@a = InvoicesItem.create!(invoice_id: inv_1_1.id, item_id: item.id, status: 'packaged', quantity: 5)
		inv_1_2 = @customer_1.invoices.create!
		@na = InvoicesItem.create!(invoice_id: inv_1_2.id, item_id: item.id, status: 'pending')

		inv_2_1 = @customer_2.invoices.create!
		@b = InvoicesItem.create!(invoice_id: inv_2_1.id, item_id: item.id, status: 'packaged', quantity: 1)
		inv_2_2 = @customer_2.invoices.create!
		@nb = InvoicesItem.create!(invoice_id: inv_2_2.id, item_id: item.id, status: 'pending')
		inv_2_3 = @customer_2.invoices.create!
		@nc = InvoicesItem.create!(invoice_id: inv_2_3.id, item_id: item.id, status: 'pending')
		
		inv_3_1 = @customer_3.invoices.create!
		@c = InvoicesItem.create!(invoice_id: inv_3_1.id, item_id: item.id, status: 'packaged', quantity: 3)
	end

	it 'has Items Ready to Ship' do
		visit "/merchants/#{@merchant.id}/dashboard"

		expect(page).to have_content("Items to Ship")
		expect(page).to have_content("Invoice ##{@a.invoice_id} - #{@a.quantity} x #{Item.find(@a.item_id).name}")
		expect(page).to have_content("Invoice ##{@b.invoice_id} - #{@b.quantity} x #{Item.find(@b.item_id).name}")
		expect(page).to have_content("Invoice ##{@c.invoice_id} - #{@c.quantity} x #{Item.find(@c.item_id).name}")

		expect(page).to_not have_content("Invoice ##{@na.invoice_id} - #{@na.quantity} x #{Item.find(@na.item_id).name}")
		expect(page).to_not have_content("Invoice ##{@nb.invoice_id} - #{@nb.quantity} x #{Item.find(@nb.item_id).name}")
		expect(page).to_not have_content("Invoice ##{@nc.invoice_id} - #{@nc.quantity} x #{Item.find(@nc.item_id).name}")
		
		click_link "Invoice ##{@a.invoice_id}"

		expect(current_path).to have_content("merchants/#{@merchant.id}/invoices/#{@a.invoice_id}")
	end
end
