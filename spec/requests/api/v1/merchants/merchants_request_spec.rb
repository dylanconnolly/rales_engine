require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(5)
  end

  it "can send one merchant by id" do
    create(:merchant)

    merchant = Merchant.last

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    output = JSON.parse(response.body)

    expect(output["data"]["attributes"]["name"]).to eq(merchant.name)
  end
end
