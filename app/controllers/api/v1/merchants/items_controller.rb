class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    items = merchant.items

    render json: ItemsSerializer.new(items)
  end
end
