require 'rails_helper'

describe "random customer API" do
  it "returns a random customer object" do
    create_list(:customer, 150)
    customer_ids = []

    Customer.all.each do |customer|
      customer_ids << customer.id
    end

    get '/api/v1/customers/random'

    expect(response).to be_successful

    parse = JSON.parse(response.body)
    random_customer_id_1 = parse["data"]["attributes"]["id"]

    expect(customer_ids).to include(random_customer_id_1)

    get '/api/v1/customers/random'
    parse = JSON.parse(response.body)
    random_customer_id_2 = parse["data"]["attributes"]["id"]

    expect(customer_ids).to include(random_customer_id_2)
    expect(random_customer_id_1).to_not eq(random_customer_id_2)
  end
end
