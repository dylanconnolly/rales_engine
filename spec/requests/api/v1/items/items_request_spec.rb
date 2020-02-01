require 'rails_helper'

describe "items API" do
  it "returns list of items" do
    create_list(:item, 10)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.count).to eq(10)
  end

  it "returns a single item found by id" do
    create_list(:item, 5)

    item = Item.last

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    parse = JSON.parse(response.body)["data"]

    expect(parse["attributes"]["id"]).to eq(item.id)
    expect(parse["attributes"]["name"]).to eq(item.name)
  end
end
