require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
	it "Exists" do
		visit "/merchants/1/dashboard"
	end
end
