require 'rails_helper'

describe "item single finder endpoints" do
  it "can find a single item based off id" do
    create_list(:item, 5)

    item = Item.all.first
    price = '%.2f' % (item.unit_price/100.0)

    get "/api/v1/items/find?id=#{item.id}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)["data"]

    expect(item_info["attributes"]["id"]).to eq(item.id)
    expect(item_info["attributes"]["name"]).to eq(item.name)
    expect(item_info["attributes"]["unit_price"]).to eq(price)
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
  it "returns all items that have an id matching the query param" do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)

    get "/api/v1/items/find_all?id=#{item1.id}"

    expect(response).to be_successful

    item1_info = JSON.parse(response.body)

    expect(item1_info["data"].first["attributes"]["id"]).to eq(item1.id)

    get "/api/v1/items/find_all?id=#{item2.id}"

    item2_info = JSON.parse(response.body)

    expect(item2_info["data"].first["attributes"]["id"]).to eq(item2.id)
  end


  it "returns all items that have a name matching the query param" do
    item1 = create(:item, name: "Cool Item")
    item2 = create(:item, name: "Cool Item")
    item3 = create(:item)

    get "/api/v1/items/find_all?name=#{item1.name}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)

    expect(item_info["data"].count).to eq(2)
    expect(item_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(item_info["data"].last["attributes"]["id"]).to eq(item2.id)
  end

  it "retuns all items that have a description matching query param" do
    item1 = create(:item, description: "Item is a good item")
    item2 = create(:item, description: "Item is a good item")
    item3 = create(:item)

    get "/api/v1/items/find_all?description=#{item1.description}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)

    expect(item_info["data"].count).to eq(2)
    expect(item_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(item_info["data"].last["attributes"]["id"]).to eq(item2.id)
  end

  it "retuns all items that have a unit price matching query param" do
    item1 = create(:item, unit_price: 21689)
    item2 = create(:item, unit_price: 21689)
    item3 = create(:item)

    get "/api/v1/items/find_all?unit_price=216.89"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)

    expect(item_info["data"].count).to eq(2)
    expect(item_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(item_info["data"].last["attributes"]["id"]).to eq(item2.id)
  end

  it "returns all items that were created on a specific date" do
    item1 = create(:item, created_at: "2020-01-10", updated_at: "2020-01-25")
    item2 = create(:item, created_at: "2020-01-10", updated_at: "2020-01-31")
    item3 = create(:item, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/items/find_all?created_at=#{item1.created_at}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)

    expect(item_info["data"].count).to eq(2)
    expect(item_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(item_info["data"].last["attributes"]["id"]).to eq(item2.id)

    get "/api/v1/items/find_all?created_at=#{item3.created_at}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)

    expect(item_info["data"].count).to eq(1)
    expect(item_info["data"].first["attributes"]["id"]).to eq(item3.id)
  end

  it "returns all items that were updated on a specific date" do
    item1 = create(:item, created_at: "2020-01-10", updated_at: "2020-01-25")
    item2 = create(:item, created_at: "2020-01-10", updated_at: "2020-01-14")
    item3 = create(:item, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/items/find_all?updated_at=#{item1.updated_at}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)

    expect(item_info["data"].count).to eq(2)
    expect(item_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(item_info["data"].last["attributes"]["id"]).to eq(item3.id)

    get "/api/v1/items/find_all?updated_at=#{item2.updated_at}"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)

    expect(item_info["data"].count).to eq(1)
    expect(item_info["data"].first["attributes"]["id"]).to eq(item2.id)
  end

  it "query params are case insensitive when looking for an item" do
    item = create(:item, name: "This Item Has Lots Of Capitals")
    description = item.description

    get "/api/v1/items/find?name=#{item.name.downcase}"

    expect(response).to be_successful
    item_info = JSON.parse(response.body)["data"]
    expect(item_info["attributes"]["id"]).to eq(item.id)

    get "/api/v1/items/find?description=#{description.upcase}"

    expect(response).to be_successful
    item_info = JSON.parse(response.body)["data"]
    expect(item_info["attributes"]["id"]).to eq(item.id)

    get "/api/v1/items/find_all?name=#{item.name.upcase}"

    expect(response).to be_successful
    item_info = JSON.parse(response.body)["data"]
    expect(item_info.first["attributes"]["id"]).to eq(item.id)

    get "/api/v1/items/find_all?description=#{description.downcase}"

    expect(response).to be_successful
    item_info = JSON.parse(response.body)["data"]
    expect(item_info.first["attributes"]["id"]).to eq(item.id)
  end

end
