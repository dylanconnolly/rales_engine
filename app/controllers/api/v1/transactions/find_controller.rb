class Api::V1::Transactions::FindController < ApplicationController

  def index
    transaction = Transaction.order(:id).find_by(converted_params)

    render json: TransactionSerializer.new(transaction)
  end

  private

    def search_params
      params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :invoice_id, :created_at, :updated_at)
    end
end
