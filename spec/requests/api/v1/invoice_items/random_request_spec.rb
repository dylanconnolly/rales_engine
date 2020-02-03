require 'rails_helper'

describe "random invoice_item API" do
  it "returns a random invoice_item object" do
    create_list(:invoice_item, 150)
    invoice_item_ids = []

    InvoiceItem.all.each do |invoice_item|
      invoice_item_ids << invoice_item.id
    end

    get '/api/v1/invoice_items/random'

    expect(response).to be_successful

    parse = JSON.parse(response.body)
    random_invoice_item1 = parse["data"]["attributes"]["id"]

    expect(invoice_item_ids).to include(random_invoice_item1)

    get '/api/v1/customers/random'
    parse = JSON.parse(response.body)
    random_invoice_item2 = parse["data"]["attributes"]["id"]

    expect(invoice_item_ids).to include(random_invoice_item2)
    expect(random_invoice_item1).to_not eq(random_invoice_item2)
  end
end
