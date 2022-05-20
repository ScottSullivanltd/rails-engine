class Api::V1::MerchantSearchController < ApplicationController
  def index
    find_info = params[:name]
    merchant = Merchant.search_for_one_merch(find_info)
    if merchant.nil?
      render json: {data: {message: "No Merchant with '#{find_info}' can be found"}}
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
