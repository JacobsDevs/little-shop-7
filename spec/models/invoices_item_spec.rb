require 'rails_helper'

RSpec.describe InvoicesItem, type: :model do
	describe 'associations' do
		it { should belong_to :invoice }
		it { should belong_to :item }

		require 'pry'; binding.pry
	end
end