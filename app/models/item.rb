class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates :unit_price, numericality: true

  # before_destroy :destroy_invoices

  belongs_to :merchant
  # has_many :invoice_items
  # has_many :invoices, through: :invoice_items

  # def destroy_invoices
  #   invoices.each do |invoice|
  #     # if
  #   end
  # end

  def self.search_for_all_items(find_info)
    Item.where("name ILIKE ?", "%#{find_info}%")
  end

  def self.items_above_min_price(price)
    Item.where("unit_price >= ?", price).order(unit_price: :asc)
  end

  def self.items_below_max_price(price)
    Item.where("unit_price <= ?", price).order(unit_price: :desc)
  end

  def self.items_between_min_max(min_price, max_price)
    Item.where("unit_price > ?", min_price) & Item.where("unit_price < ?", max_price)
  end
end
