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
		end
	end
	describe 'Merchant Items Show' do
		it 'Has all the item attributes' do	
			item = Item.all.first

			visit "/merchants/#{item.merchant.id}/items/#{item.id}"
			
			expect(page).to have_content("Name: #{item.name}")
			expect(page).to have_content("Description: #{item.description}")
			expect(page).to have_content("Price: #{item.unit_price}")
		end
	end
end