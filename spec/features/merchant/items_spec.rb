require 'rails_helper'

RSpec.describe 'Merchant Items page' do
	describe 'Merchant Items Index' do
		it 'Has just that Merchant\'s Items' do
			merchant = Merchant.find(1)
			items = merchant.items
			
			visit "merchants/#{merchant.id}/items"
			
			items.each do |item|
				expect(page).to have_content(item.name)
			end
			
			expect(page).to_not have_content(Item.find(16).name)
		end
		it 'Each item name is a link to that item show page' do
			merchant = Merchant.find(1)

			visit "/merchants/#{merchant.id}/items"

			click_link "#{merchant.items.first.name}"

			expect(current_path).to eq("/merchants/#{merchant.id}/items/#{merchant.items.first.id}")
			expect(page).to have_content("Name: #{merchant.items.first.name}")
			expect(page).to have_content("Description: #{merchant.items.first.description}")
			expect(page).to have_content("Price: #{merchant.items.first.unit_price}")
		end
	end
end