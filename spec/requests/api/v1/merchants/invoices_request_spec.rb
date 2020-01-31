require 'rails_helper'

describe "merchant invoices API" do
  it "sends a list of invoices belonging to that merchant" do
    merchant = create(:merchant)

    create_list(:invoice, 4, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful

    merchant_invoices = JSON.parse(response.body)

    expect(merchant_invoices["data"].count).to eq(4)
    merchant_invoices["data"].each do |invoice|
      expect(invoice["relationships"]["merchant"]["data"]["id"]).to eq(merchant.id.to_s)
    end
  end
end
