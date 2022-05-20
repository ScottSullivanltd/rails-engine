class Api::V1::ItemSearchController < ApplicationController
  def index
    if name_present_minmax_not_present?
      find_info = params[:name]
      items = Item.search_for_all_items(find_info)
      if items.nil?
        render json: {data: {message: "No Item with '#{find_info}' can be found"}}, status: 404
      else
        render json: ItemSerializer.new(items)
      end
    elsif min_present_name_and_max_not_present?
      price = params[:min_price].to_f
      items = Item.items_above_min_price(price)
      if items.nil?
        render json: ItemSerializer.new(items), status: 404
      else
        render json: ItemSerializer.new(items), status: 200
      end
    elsif max_present_name_and_min_not_present?
      price = params[:max_price].to_f
      items = Item.items_below_max_price(price)
      if items.nil?
        render json: ItemSerializer.new(items), status: 404
      else
        render json: ItemSerializer.new(items), status: 200
      end
    elsif min_price_max_price_present?
      max_price = params[:max_price].to_f
      min_price = params[:min_price].to_f
      items = Item.items_between_min_max(min_price, max_price)
      if items.nil?
        render json: ItemSerializer.new(items), status: 404
      else
        render json: ItemSerializer.new(items), status: 200
      end
    end
  end

  private

  def name_present_minmax_not_present?
    params[:name].present? && params[:min_price].blank? && params[:max_price].blank?
  end

  def min_present_name_and_max_not_present?
    params[:min_price].present? && params[:max_price].blank? && params[:name].blank?
  end

  def max_present_name_and_min_not_present?
    params[:max_price].present? && params[:min_price].blank? && params[:name].blank?
  end

  def min_price_max_price_present?
    params[:min_price].present? && params[:max_price].present? && params[:name].blank?
  end
end
