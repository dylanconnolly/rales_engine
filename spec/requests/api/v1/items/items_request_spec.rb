require 'rails_helper'

describe "items API" do
  it "returns list of items" do
    create_list(:item, 10)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.count).to eq(10)
  end
end
