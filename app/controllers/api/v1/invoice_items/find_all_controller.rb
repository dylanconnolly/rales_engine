class Api::V1::InvoiceItems::FindAllController < ApplicationController

  def index
    invoice_items = InvoiceItem.order(:id).where(converted_params)

    render json: InvoiceItemSerializer.new(invoice_items)
  end

  private

    def search_params
      params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
    end
end
