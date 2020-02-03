class Api::V1::Invoices::TransactionsController < ApplicationController

  def index
    invoice = Invoice.find(params[:invoice_id])
    transactions = invoice.transactions.order('transactions.id')

    render json: TransactionSerializer.new(transactions)
  end
end
