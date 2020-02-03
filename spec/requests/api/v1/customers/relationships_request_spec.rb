require 'rails_helper'

describe "customers relationships requests" do
  it "returns a collection of invoices belonging to customer" do
    customer = create(:customer)
    create_list(:invoice, 5, customer_id: customer.id)

    first_invoice = Invoice.first

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices.count).to eq(5)
    expect(invoices.first["attributes"]["id"]).to eq(first_invoice.id)
    expect(invoices.last["attributes"]["customer_id"]).to eq(customer.id)
  end
end
