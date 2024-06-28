require 'rails_helper'

RSpec.describe Item, type: :model do
	describe 'associations' do
		it { should have_many :invoices_items }
		it { should have_many :invoices }
	end
end