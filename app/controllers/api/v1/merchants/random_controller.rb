class Api::V1::Merchants::RandomController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all.sample)
  end
end
