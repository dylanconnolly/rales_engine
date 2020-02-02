class Api::V1::Invoices::FindAllController < ApplicationController

  def index
    invoices = Invoice.order(:id).where(converted_params)

    render json: InvoiceSerializer.new(invoices)
  end

  private

    def search_params
      params.permit(:id, :status, :merchant_id, :customer_id, :created_at, :updated_at)
    end
end
