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
    it 'can enable/disable items and put them in the Enabled and Disabled items list' do
      merchant = Merchant.first
      
      visit "/merchants/#{merchant.id}/items"
      within all('ul').last do
        within first('li') do |node|
          expect(node).to have_content('Esse')
          expect(find('i')).to have_content('Disabled')
          click_button "Enable Item"
        end
      end
      within first('ul') do
        within first('li') do |node|
          expect(node).to have_content('Esse')
          expect(find('i')).to have_content('Enabled')
          click_button "Disable Item"
        end
      end
      within all('ul').last do
        within first('li') do |node|
          expect(node).to have_content('Esse')
          expect(find('i')).to have_content('Disabled')
        end
      end
    end
    it 'has 5 most popular items' do
      merchant = Merchant.first

      visit "/merchants/#{merchant.id}/items"

      within first('#top_5') do
        within first('li') do |node|
          expect(node).to have_content('Voluptatem Sint')
          expect(node).to have_content('$891,810.00')
        end
      end
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
		it  'can update items' do
			item = Item.all.first

			visit "/merchants/#{item.merchant.id}/items/#{item.id}"
			
			click_link "Update Item"
			
			expect(page).to have_field('Name', with: "#{item.name}")
			expect(page).to have_field('Description', with: "#{item.description}")
			expect(page).to have_field('Unit price', with: "#{item.unit_price}")
			
			fill_in 'Name', with: "Cheetos"

      click_button "Save Item"

			expect(Item.all.first.name).to eq("Cheetos")
			expect(current_path).to have_content("/merchants/#{item.merchant.id}/items/#{item.id}")
			expect(page).to have_content("Updated Successfully")
		end
	end

  describe 'Merchant Items New' do
    it 'can create a new Item' do
      merchant = Merchant.create!(name: "Alonzee")
      
      visit "/merchants/#{merchant.id}/items"

      click_link "New Item"
      fill_in 'Name', with: "Cheetos"
      fill_in 'Description', with: "A lovely snack"
      fill_in 'Unit price', with: 1093

      click_button "Submit"

      expect(current_path).to have_content("/merchants/#{merchant.id}/items")
      within all('ul').last do
        expect(page).to have_content('Cheetos - Disabled')
      end
    end
  end
end