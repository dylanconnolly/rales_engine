class Api::V1::Invoices::FindController < ApplicationController

  def index
    invoice = Invoice.order(:id).find_by(converted_params)

    render json: InvoiceSerializer.new(invoice)
  end

  private

    def search_params
      params.permit(:id, :status, :merchant_id, :customer_id, :created_ay, :updated_at)
    end
end
