class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

  def self.search_for_one_merch(find_info)
    Merchant.where("name ILIKE ?", "%#{find_info}%").first
  end
end
