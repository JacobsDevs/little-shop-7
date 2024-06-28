require 'rails_helper'

RSpec.describe Merchant, type: :model do
	describe 'associations' do
		it { should have_many :items }
	end

	describe 'methods' do
		it 'can #get_best_customers' do
			require 'pry'; binding.pry
		end
	end
end