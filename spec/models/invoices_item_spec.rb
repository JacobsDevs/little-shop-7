require 'rails_helper'

RSpec.describe InvoicesItem, type: :model do
	describe 'associations' do
		it { should belong_to :invoice }
		it { should belong_to :item }
	end
	describe 'methods' do
		before(:each) do
			@merchant = Merchant.create!
			item = @merchant.items.create!
			@customer_1 = Customer.create!(first_name: "Secondbest", last_name: "Customer")
			@customer_2 = Customer.create!(first_name: "Best", last_name: "Customer")
			@customer_3 = Customer.create!(first_name: "Worst", last_name: "Customer")
	
			inv_1_1 = @customer_1.invoices.create!
			@a = InvoicesItem.create!(invoice_id: inv_1_1.id, item_id: item.id, status: 'packaged')
			inv_1_2 = @customer_1.invoices.create!
			InvoicesItem.create!(invoice_id: inv_1_2.id, item_id: item.id, status: 'pending')
	
			inv_2_1 = @customer_2.invoices.create!
			@b = InvoicesItem.create!(invoice_id: inv_2_1.id, item_id: item.id, status: 'packaged')
			inv_2_2 = @customer_2.invoices.create!
			InvoicesItem.create!(invoice_id: inv_2_2.id, item_id: item.id, status: 'pending')
			inv_2_3 = @customer_2.invoices.create!
			InvoicesItem.create!(invoice_id: inv_2_3.id, item_id: item.id, status: 'pending')
			
			inv_3_1 = @customer_3.invoices.create!
			@c = InvoicesItem.create!(invoice_id: inv_3_1.id, item_id: item.id, status: 'packaged')
		end

		it 'can #get_ready_to_ship' do
			expect(InvoicesItem.get_ready_to_ship(@merchant.id)).to eq([@a, @b, @c])
		end
	end
end