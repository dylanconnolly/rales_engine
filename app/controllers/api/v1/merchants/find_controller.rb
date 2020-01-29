class Api::V1::Merchants::FindController < ApplicationController

  def index
    merchant = Merchant.find_by(request.query_parameters)
    
    render json: MerchantSerializer.new(merchant)
  end
end

# Merchant.find_by(request.query_params)
