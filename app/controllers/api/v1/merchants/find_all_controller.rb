class Api::V1::Merchants::FindAllController < ApplicationController

  def index
    merchants = Merchant.where(request.query_parameters)

    render json: MerchantSerializer.new(merchants)
  end
end
