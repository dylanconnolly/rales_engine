class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def index
    invoice = Invoice.find(params[:invoice_id])
    invoice_items = invoice.invoice_items.order('invoice_items.id')

    render json: InvoiceItemSerializer.new(invoice_items)
  end
end
