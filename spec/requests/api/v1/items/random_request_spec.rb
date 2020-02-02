require 'rails_helper'

describe "random item API" do
  it "returns a random item object" do
    create_list(:item, 150)
    item_ids = []

    Item.all.each do |item|
      item_ids << item.id
    end

    get '/api/v1/items/random'

    expect(response).to be_successful

    parse = JSON.parse(response.body)
    random_item_id_1 = parse["data"]["attributes"]["id"]

    expect(item_ids).to include(random_item_id_1)

    get '/api/v1/items/random'
    parse = JSON.parse(response.body)
    random_item_id_2 = parse["data"]["attributes"]["id"]

    expect(item_ids).to include(random_item_id_2)
    expect(random_item_id_1).to_not eq(random_item_id_2)
  end
end
