class Merchant::ItemController < ApplicationController
	def index
		@merchant = Merchant.find(params[:merchant_id])
	end
	
	def show
		@merchant = Merchant.find(params[:merchant_id])
		@item = Item.find(params[:id])
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		item = Item.find(params[:id])
		item.update!(item_params)

		redirect_to merchant_item_path(item.merchant, item), notice: "Updated Successfully"
	end

private
	def item_params
		params.permit(:name, :description, :unit_price)
	end
end