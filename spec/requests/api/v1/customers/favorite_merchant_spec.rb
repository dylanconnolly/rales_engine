require 'rails_helper'

describe "customer favorite merchant request" do
  it "sends the merchant where the customer has conducted the most successful transactions" do
    fav_merchant = create(:merchant)
    not_fav_merchant = create(:merchant)
    customer = create(:customer)

    create_list(:invoice, 5, customer_id: customer.id, merchant_id: fav_merchant.id)
    create_list(:invoice, 3, customer_id: customer.id, merchant_id: not_fav_merchant.id)

    Invoice.all.each do |invoice|
      create(:transaction, invoice_id: invoice.id)
    end

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)["data"]

    expect(merchant_info["attributes"]["id"]).to eq(fav_merchant.id)
  end
end
