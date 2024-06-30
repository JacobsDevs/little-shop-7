class MerchantController < ApplicationController
	def dashboard
		@merchant = Merchant.find(params[:id])
		@top_five_hash = Customer.build_top_five_customers_hash(params[:id]) 
		@items_to_ship = @merchant.get_ready_to_ship_orders
	end
end