require 'rails_helper'

describe "invoice_items relationships requests" do
  it "returns the associated invoice belonging to that invoice_item" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
  end

  it "returns the item belonging to that invoice_item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item_id: item.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful

    item_info = JSON.parse(response.body)["data"]


    expect(item_info["attributes"]["id"]).to eq(item.id)
  end
end
