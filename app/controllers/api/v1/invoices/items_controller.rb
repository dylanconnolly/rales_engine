class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    invoice = Invoice.find(params[:invoice_id])
    items = invoice.items.order('items.id')

    render json: ItemSerializer.new(items)
  end
end
