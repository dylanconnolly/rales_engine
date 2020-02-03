require 'rails_helper'

describe "transactions relationships requests" do
  it "returns the associated invoice belonging to that transaction" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
  end
end
