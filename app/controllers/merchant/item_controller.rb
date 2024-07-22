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

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.items.create!(item_params)

    redirect_to merchant_items_path(@merchant)
  end

  def change_status
    item = Item.find(params[:format])
    item.change_status
    redirect_to merchant_items_path(item.merchant)
  end

private
	def item_params
		params.permit(:name, :description, :unit_price)
	end
end