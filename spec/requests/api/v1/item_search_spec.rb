require "rails_helper"

RSpec.describe "Items Search" do
  it "returns all items by given search term(s)" do
    merchant = create(:merchant)
    item1 = create(:item, name: "Titanium Ring", merchant_id: merchant.id)
    item2 = create(:item, name: "Touring Bike", merchant_id: merchant.id)
    item3 = create(:item, name: "Hoola Hoop", merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=ring"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items).to be_an(Array)
    # expect(items).to include(item1[:name])
    # expect(items).to include(item2[:name])
    expect(items).to_not include(item3[:name])
  end
end
