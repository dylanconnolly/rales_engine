require 'rails_helper'

describe "best day request" do
  it "returns date item had most sales" do
    item = create(:item)

    create_list(:invoice, 5, created_at: '2020-01-30')
    create_list(:invoice, 3, created_at: '2020-01-14')

    Invoice.all.each do |invoice|
      create(:transaction, invoice: invoice)
    end

    get "/api/v1/items/#{item.id}/best_day"

    expect(response).to be_successful

    best_day = JSON.parse(response.body)["data"]

    expect(best_day["attributes"]["best_day"]).to eq("2020-01-30")
  end
end
