class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all), status: :ok
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id])), status: :ok
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
    else
      render json: item.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id]) # this is needed to raise excpetion if there is no merchant
      render json: ItemSerializer.new(Item.update(params[:id], item_params)), status: :ok
    else
      render json: ItemSerializer.new(Item.update(params[:id], item_params)), status: :ok
    end
  end

  def destroy
    # item = Item.find_by(id: params[:id])
    # item.destroy
    # render json: {message: "Item is removed."}, status: :no_content
    render json: Item.destroy(params[:id]), status: :no_content
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
