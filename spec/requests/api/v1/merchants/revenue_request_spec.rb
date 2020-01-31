require 'rails_helper'

describe "merchant API" do
  it "can return lists based of search params in uri" do
    merchants = create_list(:merchant_with_items, 3)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchants.first)
    merchants.first.items.each do |item|
      create(:invoice_item, invoice: invoice, item: item)
    end
    create(:transaction, invoice: invoice)

    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_successful

    list = JSON.parse(response.body)

    expect(list["data"].first["id"]).to eq("#{merchants.first.id}")
  end

  it "returns total revenue across all merchants on a specified date" do
    create_list(:invoice, 10)

    Invoice.all.each do |invoice|
      create(:invoice_item, invoice: invoice, item: (create(:item, merchant: invoice.merchant)))
      create(:transaction, invoice: invoice)
    end

    date = Invoice.first.created_at.strftime('%Y-%m-%d')

    get "/api/v1/merchants/revenue?date=#{date}"

    expect(response).to be_successful

    query = JSON.parse(response.body)

    expect(query["data"]["attributes"]["total_revenue"]).to eq("10.0")
  end
end
