class Api::V1::Customers::FindController < ApplicationController

  def index
    customer = Customer.order(:id).find_by(converted_params)

    render json: CustomerSerializer.new(customer)
  end

  private

    def search_params
      params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
    end
end
