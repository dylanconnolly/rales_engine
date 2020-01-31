class Api::V1::Merchants::FindAllController < ApplicationController

  def index
    merchants = Merchant.where(search_params)

    render json: MerchantSerializer.new(merchants)
  end

  private

    def search_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end
