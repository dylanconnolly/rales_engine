class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def index
    customer = Customer.find(params[:customer_id])
    favorite_merchant = Merchant.favorite_merchant(customer.id)
    favorite_merchant_without_array = favorite_merchant[0]

    render json: MerchantSerializer.new(favorite_merchant_without_array)
  end
end
