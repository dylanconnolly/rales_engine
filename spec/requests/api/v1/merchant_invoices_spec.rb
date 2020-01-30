require 'rails_helper'

describe "merchant invoices API" do
  it "sends a list of invoices belonging to that merchant" do
    merchant = create(:merchant)

    create_list(:invoice, 4, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successul

    merchant_invoices = JSON.parse(response.body)

    expect(merchant_invoices["data"]["id"]).to eq(merchant.id)
    expect(merchant_invoices["data"]["relationships"]).to eq(merchant.id)
  end
end
