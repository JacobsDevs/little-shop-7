require 'rails_helper'

RSpec.describe Invoice, type: :model do
	describe 'associations' do
		it { should belong_to :customer}
		it { should have_many :transactions}
		it { should have_many :invoices_items}
		it { should have_many(:items).through(:invoices_items)}
	end
	describe 'methods' do
		before(:each) do
			@merchant = Merchant.create!
			item = @merchant.items.create!
			@customer_1 = Customer.create!(first_name: "Secondbest", last_name: "Customer")
			@customer_2 = Customer.create!(first_name: "Best", last_name: "Customer")
			@customer_3 = Customer.create!(first_name: "Worst", last_name: "Customer")
	
			inv_1_1 = @customer_1.invoices.create!
			InvoicesItem.create!(invoice_id: inv_1_1.id, item_id: item.id)
			inv_1_1.transactions.create!(result: "success")
			inv_1_2 = @customer_1.invoices.create!
			InvoicesItem.create!(invoice_id: inv_1_2.id, item_id: item.id)
			inv_1_2.transactions.create!(result: "success")
	
			inv_2_1 = @customer_2.invoices.create!
			InvoicesItem.create!(invoice_id: inv_2_1.id, item_id: item.id)
			inv_2_1.transactions.create!(result: "success")
			inv_2_2 = @customer_2.invoices.create!
			InvoicesItem.create!(invoice_id: inv_2_2.id, item_id: item.id)
			inv_2_2.transactions.create!(result: "success")
			inv_2_3 = @customer_2.invoices.create!
			InvoicesItem.create!(invoice_id: inv_2_3.id, item_id: item.id)
			inv_2_3.transactions.create!(result: "success")
			
			inv_3_1 = @customer_3.invoices.create!
			InvoicesItem.create!(invoice_id: inv_3_1.id, item_id: item.id)
			inv_3_1.transactions.create!(result: "success")
		end
		it 'can #get_successful_transaction_count_for_merchant' do
			expect(Invoice.get_successful_transaction_count_for_merchant(@customer_1.id, @merchant.id)).to eq(2)
			expect(Invoice.get_successful_transaction_count_for_merchant(@customer_2.id, @merchant.id)).to eq(3)
			expect(Invoice.get_successful_transaction_count_for_merchant(@customer_3.id, @merchant.id)).to eq(1)
		end
	end
end