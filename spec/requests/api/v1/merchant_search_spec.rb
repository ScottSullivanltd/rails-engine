require "rails_helper"

RSpec.describe "Merchant Search" do
  it "returns one merchant by a given search term" do
    merchant1 = create(:merchant, name: "Turing")
    merchant2 = create(:merchant, name: "Ring World")
    merchant3 = create(:merchant, name: "King Soopers")

    get "/api/v1/merchants/find?name=ring"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to be_an(Integer)

    expect(merchant[:type]).to eq("merchant")

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
    expect(merchant[:attributes][:name]).to eq("Ring World")
  end
end
