class Api::V1::MerchantItemsController < ApplicationController
  def index
    if Item.exists?(merchant_id: params[:merchant_id])
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    else
      render json: {error: {message: "No items found for merchant id: #{params[:merchant_id]}"}}, status: 404
    end
  end

  def show
    if Item.exists?(params[:item_id])
      render json: MerchantSerializer.new(Merchant.find(item_merchant))
    else
      render json: {error: {message: "Item not found"}}, status: 404
    end
  end

  private

  def item_merchant
    Item.find(params[:item_id])[:merchant_id]
  end
end
