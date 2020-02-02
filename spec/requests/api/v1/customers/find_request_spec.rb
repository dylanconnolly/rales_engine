require 'rails_helper'

describe "customer single finder endpoints" do
  it "can find a single customer based off id" do
    create_list(:customer, 5)

    customer = Customer.first

    get "/api/v1/customers/find?id=#{customer.id}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)["data"]

    expect(customer_info["attributes"]["id"]).to eq(customer.id)
  end

  it "returns a single instance of customer based off first name" do
    create_list(:customer, 5)

    customer = Customer.first

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)["data"]

    expect(customer_info["attributes"]["id"]).to eq(customer.id)
  end

  it "returns a single instance of customer based off last name" do
    create_list(:customer, 5)

    customer = Customer.first

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)["data"]

    expect(customer_info["attributes"]["id"]).to eq(customer.id)
  end

  it "returns a single instance of customer based off date created" do
    customer = create(:customer, created_at: "2020-01-10", updated_at: "2020-01-25")

    created_at = customer.created_at.to_s

    get "/api/v1/customers/find?created_at=#{created_at}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)["data"]

    expect(customer_info["attributes"]["id"]).to eq(customer.id)
  end

  it "returns a single instance of customer based off date updated" do
    customer = create(:customer, created_at: "2020-01-10", updated_at: "2020-01-25")

    updated_at = customer.updated_at.to_s

    get "/api/v1/customers/find?updated_at=#{updated_at}"

    expect(response).to be_successful


    customer_info = JSON.parse(response.body)["data"]

    expect(customer_info["attributes"]["id"]).to eq(customer.id)
  end
end

describe "customer find_all request" do
  it "returns all customers that have an id matching the query param" do
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer1.id}"

    expect(response).to be_successful

    customer1_info = JSON.parse(response.body)

    expect(customer1_info["data"].first["attributes"]["id"]).to eq(customer1.id)

    get "/api/v1/customers/find_all?id=#{customer2.id}"

    customer2_info = JSON.parse(response.body)

    expect(customer2_info["data"].first["attributes"]["id"]).to eq(customer2.id)
  end


  it "returns all customers that have a first name matching the query param" do
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer, first_name: "Jimmy")

    get "/api/v1/customers/find_all?first_name=#{customer1.first_name}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)

    expect(customer_info["data"].count).to eq(2)
    expect(customer_info["data"].first["attributes"]["id"]).to eq(customer1.id)
    expect(customer_info["data"].last["attributes"]["id"]).to eq(customer2.id)
  end

  it "retuns all customers that have a last name matching query param" do
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer, last_name: "Stark")

    get "/api/v1/customers/find_all?last_name=#{customer1.last_name}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)

    expect(customer_info["data"].count).to eq(2)
    expect(customer_info["data"].first["attributes"]["id"]).to eq(customer1.id)
    expect(customer_info["data"].last["attributes"]["id"]).to eq(customer2.id)

    get "/api/v1/customers/find_all?last_name=#{customer3.last_name}"

    customer_info = JSON.parse(response.body)

    expect(customer_info["data"].count).to eq(1)
    expect(customer_info["data"].first["attributes"]["id"]).to eq(customer3.id)
  end

  it "returns all customers that were created on a specific date" do
    customer1 = create(:customer, created_at: "2020-01-10", updated_at: "2020-01-25")
    customer2 = create(:customer, created_at: "2020-01-10", updated_at: "2020-01-31")
    customer3 = create(:customer, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/customers/find_all?created_at=#{customer1.created_at}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)

    expect(customer_info["data"].count).to eq(2)
    expect(customer_info["data"].first["attributes"]["id"]).to eq(customer1.id)
    expect(customer_info["data"].last["attributes"]["id"]).to eq(customer2.id)

    get "/api/v1/customers/find_all?created_at=#{customer3.created_at}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)

    expect(customer_info["data"].count).to eq(1)
    expect(customer_info["data"].first["attributes"]["id"]).to eq(customer3.id)
  end

  it "returns all customers that were updated on a specific date" do
    customer1 = create(:customer, created_at: "2020-01-10", updated_at: "2020-01-25")
    customer2 = create(:customer, created_at: "2020-01-10", updated_at: "2020-01-14")
    customer3 = create(:customer, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/customers/find_all?updated_at=#{customer1.updated_at}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)

    expect(customer_info["data"].count).to eq(2)
    expect(customer_info["data"].first["attributes"]["id"]).to eq(customer1.id)
    expect(customer_info["data"].last["attributes"]["id"]).to eq(customer3.id)

    get "/api/v1/customers/find_all?updated_at=#{customer2.updated_at}"

    expect(response).to be_successful

    customer_info = JSON.parse(response.body)

    expect(customer_info["data"].count).to eq(1)
    expect(customer_info["data"].first["attributes"]["id"]).to eq(customer2.id)
  end

  it "query params are case insensitive when looking for an item" do
    customer = create(:customer)


    get "/api/v1/customers/find?first_name=DAVID"

    expect(response).to be_successful
    customer_info = JSON.parse(response.body)["data"]
    expect(customer_info["attributes"]["id"]).to eq(customer.id)

    get "/api/v1/customers/find?last_name=BOWIE"

    expect(response).to be_successful
    customer_info = JSON.parse(response.body)["data"]
    expect(customer_info["attributes"]["id"]).to eq(customer.id)

    get "/api/v1/customers/find_all?first_name=david"

    expect(response).to be_successful
    customer_info = JSON.parse(response.body)["data"]
    expect(customer_info.first["attributes"]["id"]).to eq(customer.id)

    get "/api/v1/customers/find_all?last_name=bowie"

    expect(response).to be_successful
    customer_info = JSON.parse(response.body)["data"]
    expect(customer_info.first["attributes"]["id"]).to eq(customer.id)
  end
end
