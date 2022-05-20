class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates :unit_price, numericality: true

  belongs_to :merchant

  def self.search_for_all_items(find_info)
    Item.where("name ILIKE ?", "%#{find_info}")
  end

  def self.items_above_min_price(price)
    Item.where("unit_price >= ?", price).order(unit_price: :asc).first
  end

  def self.items_below_max_price(price)
    Item.where("unit_price <= ?", price).order(unit_price: :desc).first
  end
end
