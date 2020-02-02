require 'rails_helper'

describe 'Invoices API' do
  it 'sends a list of all merchants' do
    create_list(:invoice, 5)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices.count).to eq(5)
  end

  it "can send one merchant by id" do
    invoice = create(:invoice)

    get "/api/v1/merchants/#{invoice.id}"

    expect(response).to be_successful

    invoice_data = JSON.parse(response.body)["data"]

    expect(invoice_data["attributes"]["id"]).to eq(invoice.id)
  end
end
