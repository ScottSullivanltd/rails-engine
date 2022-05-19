class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all), status: :ok
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id])), status: :ok
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)), status: :created
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params)), status: :ok
  end

  # def update
  #   item = Item.find_by(id: params[:id])
  #   item.update(item_params)
  #   render json: ItemSerializer.new(item)
  # end

  def destroy
    # item = Item.find_by(id: params[:id])
    # item.destroy
    # render json: {message: "Item is removed."}, status: :no_content
    render json: Item.destroy(params[:id]), status: :no_content
    # render json: ItemSerializer.new(Item.delete(id: params[:id])), status: :ok
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
