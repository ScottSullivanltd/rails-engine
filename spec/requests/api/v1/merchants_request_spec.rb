require "rails_helper"

RSpec.describe "Merchants API" do
  it "sends a list of all merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)

      expect(merchant[:type]).to eq("merchant")

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(:ok)
    expect(merchant[:data][:attributes]).to include(:name)
  end

  it "returns all items associated with a given merchant" do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(response).to have_http_status(:ok)
    expect(merchant.items.count).to eq(3)

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
end
