class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(5))
  end
end
