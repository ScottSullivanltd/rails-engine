class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item

  validates :quantity, presence: true
  validates :unit_price, presence: true, numericality: true
end
