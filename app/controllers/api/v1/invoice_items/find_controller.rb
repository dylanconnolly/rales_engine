class Api::V1::InvoiceItems::FindController < ApplicationController

  def index
    invoice_item = InvoiceItem.order(:id).find_by(converted_params)

    render json: InvoiceItemSerializer.new(invoice_item)
  end

  private

    def search_params
      params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
    end
end
