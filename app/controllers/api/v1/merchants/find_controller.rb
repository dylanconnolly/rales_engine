class Api::V1::Merchants::FindController < ApplicationController

  def index
    merchant = Merchant.find_by(search_params)

    # merchant = Merchant.find_by(request.query_parameters)
    require "pry"; binding.pry
    render json: MerchantSerializer.new(merchant)
  end

  private

    def search_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end
