require 'rails_helper'

RSpec.describe Customer, type: :model do
	describe 'associations' do
		it { should have_many :invoices }
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
		it 'can #get_most_transactions for a merchant' do			
			expect(Customer.get_most_transactions(@merchant.id, 3)).to eq([@customer_2, @customer_1, @customer_3])
		end
		it 'can #get_customers_successful_transactions for merchant' do
			expect(Customer.get_customers_successful_transactions([@customer_1, @customer_2, @customer_3], @merchant.id)).to eq([2, 3, 1])
		end
		it 'can #build_top_five_customers_hash' do
			expect(Customer.build_top_five_customers_hash(@merchant.id)).to eq({"#{@customer_2.first_name} #{@customer_2.last_name}" => 3,
																																					"#{@customer_1.first_name} #{@customer_1.last_name}" => 2,
																																					"#{@customer_3.first_name} #{@customer_3.last_name}" => 1})
		end
	end
end
