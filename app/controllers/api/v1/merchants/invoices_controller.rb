class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    invoices = merchant.invoices

    render json: InvoicesSerializer.new(invoices)
  end
end
