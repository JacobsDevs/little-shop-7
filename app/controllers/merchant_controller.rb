class MerchantController < ApplicationController
	def dashboard
		@merchant = Merchant.find(params[:id])
		@top_five_hash = Customer.build_top_five_customers_hash(params[:id]) 
	end
end