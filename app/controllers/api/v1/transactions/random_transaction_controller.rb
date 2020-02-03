class Api::V1::Transactions::RandomTransactionController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.all.sample)
  end
end
