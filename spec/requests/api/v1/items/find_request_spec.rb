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

end
