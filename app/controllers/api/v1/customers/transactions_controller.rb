class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    customer = Customer.find(params[:customer_id])
    transactions = customer.transactions.order('transactions.id')

    render json: TransactionSerializer.new(transactions)
  end
end
