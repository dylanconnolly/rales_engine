class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  scope :customer, -> (id) {where("customer_id = ?", id)}
  scope :merchant, -> (id) { where("merchant_id = ?", id)}

  has_many :transactions
  has_many :invoice_items, :dependent => :destroy
  has_many :items, through: :invoice_items, :dependent => :destroy

  enum status: ["unshipped", "shipped"]
end
