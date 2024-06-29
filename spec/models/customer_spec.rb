require 'rails_helper'

RSpec.describe Customer, type: :model do
	describe 'associations' do
		it { should have_many :invoices }
	end
	describe 'methods' do
		it 'can #get_most_transactions for a merchant' do
			merchant = Merchant.create!
			item = merchant.items.create!
			customer_1 = Customer.create!(first_name: "Secondbest", last_name: "Customer")
			customer_2 = Customer.create!(first_name: "Best", last_name: "Customer")
			customer_3 = Customer.create!(first_name: "Worst", last_name: "Customer")

			inv_1_1 = customer_1.invoices.create!
			InvoicesItem.create!(invoice_id: inv_1_1.id, item_id: item.id)
			inv_1_1.transactions.create!(result: "success")
			inv_1_2 = customer_1.invoices.create!
			InvoicesItem.create!(invoice_id: inv_1_2.id, item_id: item.id)
			inv_1_2.transactions.create!(result: "success")

			inv_2_1 = customer_2.invoices.create!
			InvoicesItem.create!(invoice_id: inv_2_1.id, item_id: item.id)
			inv_2_1.transactions.create!(result: "success")
			inv_2_2 = customer_2.invoices.create!
			InvoicesItem.create!(invoice_id: inv_2_2.id, item_id: item.id)
			inv_2_2.transactions.create!(result: "success")
			inv_2_3 = customer_2.invoices.create!
			InvoicesItem.create!(invoice_id: inv_2_3.id, item_id: item.id)
			inv_2_3.transactions.create!(result: "success")
			
			inv_3_1 = customer_3.invoices.create!
			InvoicesItem.create!(invoice_id: inv_3_1.id, item_id: item.id)
			inv_3_1.transactions.create!(result: "success")
			
			expect(Customer.get_most_transactions(merchant.id, 3)).to eq([customer_2, customer_1, customer_3])
		end
	end
end
