require 'rails_helper'

RSpec.describe 'Merchant Items page' do
	it 'has an index page with just that Merchant\'s Items' do
		merchant = Merchant.find(1)
		items = merchant.items

		visit "merchants/#{merchant.id}/items"

		save_and_open_page
		items.each do |item|
			expect(page).to have_content(item.name)
		end

		expect(page).to_not have_content(Item.find(16).name)
	end
end