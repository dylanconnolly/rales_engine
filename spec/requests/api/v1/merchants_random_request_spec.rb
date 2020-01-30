require 'rails_helper'

describe "random merchant API" do
  it "returns a random merchant object" do
    create_list(:merchant, 4)
    merchant_ids = []

    Merchant.all.each do |merchant|
      merchant_ids << merchant.id
    end

    get '/api/v1/merchants/random'

    expect(response).to be_successful

    random_merchant = JSON.parse(response.body)

    expect(merchant_ids).to include(random_merchant["data"]["attributes"]["id"])

    get '/api/v1/merchants/random'

    expect(merchant_ids).to include(random_merchant["data"]["attributes"]["id"])
  end
end
