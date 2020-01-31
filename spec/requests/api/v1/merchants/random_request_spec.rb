require 'rails_helper'

describe "random merchant API" do
  it "returns a random merchant object" do
    create_list(:merchant, 150)
    merchant_ids = []

    Merchant.all.each do |merchant|
      merchant_ids << merchant.id
    end

    get '/api/v1/merchants/random'

    expect(response).to be_successful

    parse = JSON.parse(response.body)
    random_merchant_id_1 = parse["data"]["attributes"]["id"]

    expect(merchant_ids).to include(random_merchant_id_1)

    get '/api/v1/merchants/random'
    parse = JSON.parse(response.body)
    random_merchant_id_2 = parse["data"]["attributes"]["id"]

    expect(merchant_ids).to include(random_merchant_id_2)
    expect(random_merchant_id_1).to_not eq(random_merchant_id_2)
  end
end
