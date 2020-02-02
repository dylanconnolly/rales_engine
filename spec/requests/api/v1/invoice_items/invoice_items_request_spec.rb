require 'rails_helper'

describe 'invoice_items API' do
  it "returns a list of all invoice_items" do
    create_list(:invoice_item, 5)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]

    expect(invoice_items.count).to eq(5)
  end

  it "returns a single record of invoice_items by id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}"

    expect(response).to be_successful

    invoice_item_data = JSON.parse(response.body)["data"]

    expect(invoice_item_data["attributes"]["id"]).to eq(invoice_item.id)
  end
end
