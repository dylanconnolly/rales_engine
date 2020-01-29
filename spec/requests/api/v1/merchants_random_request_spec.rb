require 'rails_helper'

describe "random merchant API" do
  it "returns a random merchant object" do
    create_list(:merchant, 10)

    get '/api/v1/merchants/random'

    expect(response).to be_successful

    random_merchant = JSON.parse(response.body)

    expect(random_merchant["data"].count).to eq(1)
  end
end
