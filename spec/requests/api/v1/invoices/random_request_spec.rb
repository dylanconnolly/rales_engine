require 'rails_helper'

describe "random invoice API" do
  it "returns a random invoice object" do
    create_list(:invoice, 150)
    invoice_ids = []

    Invoice.all.each do |invoice|
      invoice_ids << invoice.id
    end

    get '/api/v1/invoices/random'

    expect(response).to be_successful

    parse = JSON.parse(response.body)
    random_invoice1 = parse["data"]["attributes"]["id"]

    expect(invoice_ids).to include(random_invoice1)

    get '/api/v1/invoices/random'
    parse = JSON.parse(response.body)
    random_invoice2 = parse["data"]["attributes"]["id"]

    expect(invoice_ids).to include(random_invoice2)
    expect(random_invoice1).to_not eq(random_invoice2)
  end
end
