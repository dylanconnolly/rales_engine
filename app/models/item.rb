class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoices, through: :invoice_items
end
