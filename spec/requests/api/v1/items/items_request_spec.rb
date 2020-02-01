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

  it "returns a single instance of item based off name" do
    create_list(:item, 10)

    item = Item.last

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)["data"]

    expect(item_info["attributes"]["name"]).to eq(item.name)
  end

  it "returns a single instance of item based off description" do
    create_list(:item, 5)

    item = Item.all.first

    get "/api/v1/items/find?description=#{item.description}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)["data"]

    expect(item_info["attributes"]["id"]).to eq(item.id)
  end

  it "returns a single instance of item based off unit price" do
    item1 = create(:item, unit_price: 1100)
    item2 = create(:item, unit_price: 2245)

    get "/api/v1/items/find?unit_price=11.00"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)["data"]

    expect(item_info["attributes"]["id"]).to eq(item1.id)

    get "/api/v1/items/find?unit_price=22.45"

    item_info = JSON.parse(response.body)["data"]

    expect(item_info["attributes"]["id"]).to eq(item2.id)
  end

  it "returns a single instance of item based off merchant id" do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)

    item = Item.all.first

    get "/api/v1/items/find?merchant_id=#{merchant.id}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)["data"]

    expect(item_info["attributes"]["id"]).to eq(item.id)
  end

  it "returns a single instance of item based off date created" do
    item = create(:item, created_at: "2020-01-10", updated_at: "2020-01-25")

    created_at = item.created_at.to_s

    get "/api/v1/items/find?created_at=#{created_at}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)["data"]

    expect(item_info["attributes"]["name"]).to eq(item.name)
  end

  it "returns a single instance of item based off date updated" do
    item = create(:item, created_at: "2020-01-10", updated_at: "2020-01-25")

    updated_at = item.updated_at.to_s

    get "/api/v1/items/find?updated_at=#{updated_at}"

    expect(response).to be_successful


    item_info = JSON.parse(response.body)["data"]

    expect(item_info["attributes"]["name"]).to eq(item.name)
  end
end

describe "item find_all request" do
  xit "returns all items that have an id matching the query param" do
    merchant1 = create(:merchant, name: "Bob")
    merchant2 = create(:merchant, name: "Scott")
    merchant3 = create(:merchant, name: "Not Bob")

    get "/api/v1/items/find_all?id=#{merchant1.id}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant1.name)
  end


  xit "returns all items that have a name matching the query param" do
    merchant1 = create(:merchant, name: "Bob")
    merchant2 = create(:merchant, name: "Bob")
    merchant3 = create(:merchant, name: "Not Bob")

    get "/api/v1/items/find_all?name=#{merchant1.name}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(2)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant1.name)
    expect(merchant_info["data"].last["attributes"]["name"]).to eq(merchant2.name)
  end

  xit "returns all items that were created on a specific date" do
    merchant1 = create(:merchant, name: "Bob", created_at: "2020-01-10", updated_at: "2020-01-25")
    merchant2 = create(:merchant, name: "Stove", created_at: "2020-01-10", updated_at: "2020-01-31")
    merchant3 = create(:merchant, name: "Not Bob", created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/items/find_all?created_at=#{merchant1.created_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(2)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant1.name)
    expect(merchant_info["data"].last["attributes"]["name"]).to eq(merchant2.name)

    get "/api/v1/items/find_all?created_at=#{merchant3.created_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(1)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant3.name)
  end

  xit "returns all items that were created on a specific date" do
    merchant1 = create(:merchant, name: "Bob", created_at: "2020-01-10", updated_at: "2020-01-25")
    merchant2 = create(:merchant, name: "Stove", created_at: "2020-01-10", updated_at: "2020-01-14")
    merchant3 = create(:merchant, name: "Not Bob", created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/items/find_all?updated_at=#{merchant1.updated_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(2)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant1.name)
    expect(merchant_info["data"].last["attributes"]["name"]).to eq(merchant3.name)

    get "/api/v1/items/find_all?updated_at=#{merchant2.updated_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(1)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant2.name)
  end
end
