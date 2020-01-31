require 'rails_helper'

describe "merchants items API" do
  it "sends a list of that merchant's items" do
    merchant = create(:merchant_with_items)
    merchant2 = create(:merchant_with_items, items_count: 3)

    items = merchant.items
    not_items = merchant2.items

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items_hash = JSON.parse(response.body)
    expect(items_hash["data"].count).to eq(5)
  end
end
