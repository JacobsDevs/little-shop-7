require 'rails_helper'

RSpec.describe 'Merchant Invoices' do
  describe 'Merchant Invoices index' do
    it 'exists and has all the Merchant Invoices' do
      merchant = Merchant.first
      
      visit "/merchants/#{merchant.id}/invoices"
      
      save_and_open_page
      merchant.items.each do |item|
        item.invoices.each do |inv|
          expect(page).to have_content("Invoice ##{inv.id}")
        end
      end
      
      within first('ul') do
        within first('a') do |node|
          expect(node['href']).to eq("/merchants/#{merchant.id}/invoices/#{merchant.items.first.invoices.first.id}")
        end
      end
    end
  end
end