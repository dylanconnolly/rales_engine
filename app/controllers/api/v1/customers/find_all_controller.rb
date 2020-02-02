class Api::V1::Customers::FindAllController < ApplicationController

  def index
    customers = Customer.order(:id).where(converted_params)

    render json: CustomerSerializer.new(customers)
  end

  private

    def search_params
      params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
    end
end
