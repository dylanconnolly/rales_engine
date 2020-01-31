class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    revenue = Merchant.total_revenue_on_date(params[:date])
    real = revenue[0]
    render json: MerchantRevenueSerializer.new(real)
  end
end
