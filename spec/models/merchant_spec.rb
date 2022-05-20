require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:items) }
  end

  describe "Merchant Search" do
    it "returns one merchant by a given search term" do
      merchant1 = create(:merchant, name: "Turing")
      merchant2 = create(:merchant, name: "Ring World")
      merchant3 = create(:merchant, name: "King Soopers")

      merchant = Merchant.search_for_one_merch("ring")

      expect(merchant).to eq(merchant1)
      expect(merchant).to_not eq(merchant2)
      expect(merchant).to_not eq(merchant3)
    end
  end
end
