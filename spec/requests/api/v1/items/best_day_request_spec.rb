require 'rails_helper'

describe "best day request" do
  it "returns date item had most sales" do
    item = create(:item)

    create_list(:invoice, 8)

    Invoice.all.each do |invoice|
      create(:transaction, invoice: invoice)
      create(:invoice_item, invoice: invoice, item: item)
      invoice.update(created_at: '2020-01-30')
    end

    Invoice.all[0].update(created_at: "2020-01-14")
    Invoice.all[1].update(created_at: "2020-01-14")
    Invoice.all[2].update(created_at: "2020-01-14")

    get "/api/v1/items/#{item.id}/best_day"

    expect(response).to be_successful

    best_day = JSON.parse(response.body)["data"]

    expect(best_day["attributes"]["best_day"]).to eq("2020-01-30")
  end
end
