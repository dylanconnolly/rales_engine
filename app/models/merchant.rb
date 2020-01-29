class Merchant < ApplicationRecord
  has_many :items, :dependent => :destroy
  has_many :invoices, :dependent => :destroy
  has_many :transactions, through: :invoices

  def self.most_revenue(number_of_records)
    Merchant.joins(invoices: [:invoice_items, :transactions]).
    select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue').
    group(:id).
    order('total_revenue desc').
    limit(number_of_records)
  end
end
