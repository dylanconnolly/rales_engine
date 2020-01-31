require 'rails_helper'

describe "merchant favorite_customer request" do
  it "sends customer info who has conducted the most successful transactions with that merchant" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    customer1 = create(:customer)
    customer2 = create(:customer)

    5.times do
      create(:invoice, merchant: merchant1, customer: customer1)
    end

    2.times do
      create(:invoice, merchant: merchant1, customer: customer2)
    end

    merchant1.invoices.each do |invoice|
      create(:transaction, invoice: invoice)
    end

    5.times do
      create(:invoice, merchant: merchant2, customer: customer2)
    end

    2.times do
      create(:invoice, merchant: merchant2, customer: customer1)
    end

    merchant2.invoices.each do |invoice|
      create(:transaction, invoice: invoice)
    end

    get "/api/v1/merchants/#{merchant1.id}/favorite_customer"

    expect(response).to be_successful

    fav_customer = JSON.parse(response.body)["data"]
    expect(fav_customer["attributes"]["first_name"]).to eq(customer1.first_name)

    get "/api/v1/merchants/#{merchant2.id}/favorite_customer"

    fav_customer = JSON.parse(response.body)["data"]
    expect(fav_customer["attributes"]["first_name"]).to eq(customer2.first_name)
  end
end
