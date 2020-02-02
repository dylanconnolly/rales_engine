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

  def self.best_day(item_id)
    Item.joins(invoices: :transactions).
    select("COUNT(invoices.created_at), date_trunc('day', invoices.created_at) AS best_day").
    group('invoices.created_at').
    merge(Transaction.successful).
    where("items.id = #{item_id}").
    order('count desc, best_day desc').
    limit(1)
  end
end

# Item.joins(invoices: :transactions).
# select("COUNT(invoices.created_at), date_trunc('day', invoices.created_at) AS best_day").
# group('invoices.created_at').
# merge(Transaction.successful).
# where("items.id = 1099").to_sql
