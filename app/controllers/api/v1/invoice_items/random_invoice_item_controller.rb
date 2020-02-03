class Api::V1::InvoiceItems::RandomInvoiceItemController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all.sample)
  end
end
