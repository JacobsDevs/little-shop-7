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
		
		expect(page).to have_content("#{top_five.keys[0]} - #{top_five.values[0]} purchase")
		expect(page).to have_content("#{top_five.keys[1]} - #{top_five.values[1]} purchase")
		expect(page).to have_content("#{top_five.keys[2]} - #{top_five.values[2]} purchase")
		expect(page).to have_content("#{top_five.keys[3]} - #{top_five.values[3]} purchase")
		expect(page).to have_content("#{top_five.keys[4]} - #{top_five.values[4]} purchase")
	end

	it 'has Items Ready to Ship' do
		visit "/merchants/1/dashboard"

	end
end
