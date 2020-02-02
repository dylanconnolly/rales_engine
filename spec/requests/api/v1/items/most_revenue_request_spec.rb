require 'rails_helper'

describe "most revenue request" do
  it "returns the top items ranked by revenue and list length is passed as query param" do
    create_list(:item, 5)

    top_item = Item.last

    number_of_invoice_items = 1
    Item.all.each do |item|
      create_list(:invoice_item, number_of_invoice_items, item: item)

      number_of_invoice_items += 1
    end

    Invoice.all.each do |invoice|
      create(:transaction, invoice: invoice)
    end

    get '/api/v1/items/most_revenue?quantity=5'

    expect(response).to be_successful

    top_revenue = JSON.parse(response.body)["data"]

    expect(top_revenue.count).to eq(5)
    expect(top_revenue.first["attributes"]["id"]).to eq(top_item.id)

    get '/api/v1/items/most_revenue?quantity=3'

    top_revenue = JSON.parse(response.body)["data"]

    expect(top_revenue.count).to eq(3)
    expect(top_revenue.first["attributes"]["id"]).to eq(top_item.id)
  end
end
