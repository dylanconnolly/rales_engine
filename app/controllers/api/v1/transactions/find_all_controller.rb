class Api::V1::Transactions::FindAllController < ApplicationController

  def index
    transactions = Transaction.order(:id).where(converted_params)

    render json: TransactionSerializer.new(transactions)
  end

  private

    def search_params
      params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :invoice_id, :created_at, :updated_at)
    end
end
