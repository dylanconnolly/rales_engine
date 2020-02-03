class Api::V1::Customers::RandomCustomerController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.all.sample)
  end
end
