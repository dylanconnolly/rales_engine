class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, :dependent => :destroy
  has_many :invoices, through: :invoice_items, :dependent => :destroy

  def self.most_revenue(number_of_records)
    joins(invoices: [:invoice_items, :transactions]).
    select('items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue').
    group(:id).
    merge(Transaction.successful).
    order('total_revenue desc').
    limit(number_of_records)
  end
end
