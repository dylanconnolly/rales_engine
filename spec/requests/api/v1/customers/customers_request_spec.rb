require 'rails_helper'

describe 'customers API' do
  it "returns a list of all customers" do
    create_list(:customer, 5)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)["data"]

    expect(customers.count).to eq(5)
  end

  it "returns a single record of customer by id" do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful

    transaction_data = JSON.parse(response.body)["data"]

    expect(transaction_data["attributes"]["id"]).to eq(customer.id)
  end
end
