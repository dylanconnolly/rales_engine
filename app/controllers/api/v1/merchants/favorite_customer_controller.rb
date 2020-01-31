class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def index
    favorite_customer = Customer.most_transactions_at_merchant(params[:merchant_id])

    render json: CustomerSerializer.new(favorite_customer[0])
  end
end
