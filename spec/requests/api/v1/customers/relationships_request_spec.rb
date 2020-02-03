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
    invoices.each do |invoice|
      expect(invoice["attributes"]["customer_id"]).to eq(customer.id)
    end
  end

  it "returns a collection of transactions belonging to that customer" do
    customer = create(:customer)
    create_list(:invoice, 5, customer_id: customer.id)

    Invoice.all.each do |invoice|
      create(:transaction, invoice_id: invoice.id)
    end

    invoice_ids = Invoice.all.map do |invoice|
        invoice.id
    end

    first_transaction = Transaction.first

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)["data"]

    expect(transactions.count).to eq(5)
    expect(transactions.first["attributes"]["id"]).to eq(first_transaction.id)
    transactions.each do |transaction|
      expect(invoice_ids).to include(transaction["attributes"]["invoice_id"])
    end
  end
end
