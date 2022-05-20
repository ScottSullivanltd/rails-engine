class Api::V1::Item::SearchController < ApplicationController
  def show
    if params[:name]
      find_info = params[:name]
      item = Item.search_for_all_items(find_info)
      if item.nil?
        render json: {data: {message: "No Item with '#{find_info}' can be found"}}, status: 404
      else
        render json: ItemSerializer.new(item)
      end
    elsif params[:min_price]
      price = params[:min_price].to_f
      item = Item.items_above_min_price(price)
      if item.nil?
        render json: ItemSerializer.new(item), status: 404
      else
        render json: ItemSerializer.new(item), status: 200
      end
    elsif params[:max_price]
      price = params[:max_price].to_f
      item = Item.items_below_max_price(price)
      if item.nil?
        render json: ItemSerializer.new(item), status: 404
      else
        render json: ItemSerializer.new(item), status: 200
      end
    end
  end
end
