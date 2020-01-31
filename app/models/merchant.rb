class Merchant < ApplicationRecord
  has_many :items, :dependent => :destroy
  has_many :invoices, :dependent => :destroy
  has_many :transactions, through: :invoices

  def self.most_revenue(number_of_records)
    joins(invoices: [:invoice_items, :transactions]).
    select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue').
    group(:id).
    merge(Transaction.successful).
    order('total_revenue desc').
    limit(number_of_records)
  end

  def self.total_revenue_on_date(date)
    starttime = Time.zone.parse(date)
    endtime = starttime + 1.day

    joins(invoices: [:invoice_items, :transactions]).
    select("date_trunc('day', invoice_items.created_at) AS day, SUM((invoice_items.unit_price * invoice_items.quantity)/100.0) AS total_revenue").
    group('day').
    merge(Transaction.successful).
    where("invoices.created_at BETWEEN '#{starttime}' AND '#{endtime}'").
    limit(1)
  end
end
