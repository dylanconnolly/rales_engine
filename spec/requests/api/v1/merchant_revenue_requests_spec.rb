require 'rails_helper'

describe "merchant API" do
  it "can return lists based of search params in uri" do
    merchants = create_list(:merchant_with_items, 3)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchants.first)
    merchants.first.items.each do |item|
      create(:invoice_item, invoice: invoice, item: item)
    end

    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_successful
  end
end
