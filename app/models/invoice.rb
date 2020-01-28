class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :items, through: :invoice_items

  enum status: ["unshipped", "shipped"]
end
