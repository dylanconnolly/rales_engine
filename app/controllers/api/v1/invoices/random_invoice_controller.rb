class Api::V1::Invoices::RandomInvoiceController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.all.sample)
  end
end
