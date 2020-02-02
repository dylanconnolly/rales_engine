require 'rails_helper'

describe 'item relationships endpoints' do
  it 'can return a collection of invoice_items belonging to an item' do
    item = create(:item)

    create_list(:invoice_item, 10, item: item)

    first = InvoiceItem.all.first
    last = InvoiceItem.last

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]

    expect(invoice_items.count).to eq(10)
    expect(invoice_items.first["attributes"]["id"]).to eq(first.id)
    expect(invoice_items.last["attributes"]["id"]).to eq(last.id)
  end
end
