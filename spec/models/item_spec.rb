require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe "relationships" do
    it { should belong_to(:merchant) }
  end

  describe "Items Search" do
    it "returns all items by given search term(s)" do
      merchant = create(:merchant)
      item1 = create(:item, name: "Titanium Ring", merchant_id: merchant.id)
      item2 = create(:item, name: "Touring Bike", merchant_id: merchant.id)
      item3 = create(:item, name: "Hoola Hoop", merchant_id: merchant.id)

      items = Item.search_for_all_items("ring")

      expect(items.count).to eq(2)
      expect(items).to include(item1)
      expect(items).to include(item2)
      expect(items).to_not include(item3)
    end

    it "returns all items above a given search price" do
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 8.99, merchant_id: merchant.id)
      item2 = create(:item, unit_price: 9.99, merchant_id: merchant.id)
      item3 = create(:item, unit_price: 11.99, merchant_id: merchant.id)

      items = Item.items_above_min_price(9.99)

      expect(items.count).to eq(2)
      expect(items).to include(item2)
      expect(items).to include(item3)
      expect(items).to_not include(item1)
    end

    it "returns all items below a given search price" do
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 8.99, merchant_id: merchant.id)
      item2 = create(:item, unit_price: 9.99, merchant_id: merchant.id)
      item3 = create(:item, unit_price: 11.99, merchant_id: merchant.id)

      items = Item.items_below_max_price(9.99)

      expect(items.count).to eq(2)
      expect(items).to include(item1)
      expect(items).to include(item2)
      expect(items).to_not include(item3)
    end

    it "returns all items between given search prices" do
      merchant = create(:merchant)
      item1 = create(:item, unit_price: 8.99, merchant_id: merchant.id)
      item2 = create(:item, unit_price: 9.99, merchant_id: merchant.id)
      item3 = create(:item, unit_price: 11.99, merchant_id: merchant.id)
      item4 = create(:item, unit_price: 15.99, merchant_id: merchant.id)

      items = Item.items_between_min_max(item1.unit_price, item4.unit_price)

      expect(items.count).to eq(2)
      expect(items).to include(item2)
      expect(items).to include(item3)
      expect(items).to_not include(item1)
      expect(items).to_not include(item4)
    end
  end
end
