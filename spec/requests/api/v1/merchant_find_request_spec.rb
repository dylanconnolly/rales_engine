require 'rails_helper'

describe "merchant finder API" do
  it "returns a single instance of a merchant based off id params" do
    create_list(:merchant, 10)

    merchant = Merchant.last

    get "/api/v1/merchants/find?id=#{merchant.id}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)
    expect(merchant_info["data"]["attributes"]["name"]).to eq(merchant.name)
  end
end
