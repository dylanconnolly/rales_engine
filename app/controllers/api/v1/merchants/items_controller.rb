class Api::V1::Merchant::ItemsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    items = merchant.items

    render json: MerchantSerializer.new(merchant)
  end
end
