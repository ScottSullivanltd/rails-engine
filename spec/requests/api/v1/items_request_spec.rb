require "rails_helper"

RSpec.describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)

      expect(item[:type]).to eq("item")

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  it "can get one item by its id" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(:ok)
    expect(item[:data][:attributes]).to include(:name)
  end

  it "can create a new item" do
    item_params = {
      name: "Laptop",
      description: "Has a screen and a keyboard.",
      unit_price: 99.99,
      merchant_id: 14
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to have_http_status(:created)
    expect(item[:attributes][:name]).to eq(item_params[:name])
    expect(item[:attributes][:description]).to eq(item_params[:description])
    expect(item[:attributes][:unit_price]).to eq(item_params[:unit_price])
    expect(item[:attributes][:merchant_id]).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id
    previous_name = Item.last.name
    item_params = {name: "Tabletop"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params)
    item = Item.find_by(id: id)

    expect(response).to have_http_status(:ok)
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Tabletop")
  end

  it "can destroy an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect { delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to have_http_status(:no_content)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "returns the merchant info for a given item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(response).to be_successful
    expect(response).to have_http_status(:ok)
    expect(merchant[:attributes]).to include(:name)
  end
end
