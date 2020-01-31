class Customer < ApplicationRecord
  has_many :invoices, :dependent => :destroy


  def self.most_transactions_at_merchant(merchant_id)
    joins(invoices: :transactions).
    select('customers.*, COUNT(transactions.id) AS successful_transactions').
    group(:id).
    merge(Transaction.successful).
    merge(Invoice.merchant(merchant_id)).
    order('successful_transactions desc').
    limit(1)
  end
end
