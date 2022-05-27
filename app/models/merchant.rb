class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.search_for_one_merch(find_info)
    Merchant.where("name ILIKE ?", "%#{find_info}%").first
  end

  def self.top_merchants_by_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .group(:id)
      .where(transactions: {result: "success"}, invoices: {status: "shipped"})
      .order(revenue: :desc)
      .limit(quantity)
  end
end
