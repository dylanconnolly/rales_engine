require 'rails_helper'

describe "item single finder endpoints" do
  it "can find a single invoice based off id" do
    create_list(:invoice, 5)

    invoice = Invoice.first

    get "/api/v1/invoices/find?id=#{invoice.id}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
  end

  it "returns a first instance of invoice based off status" do
    create_list(:invoice, 3)
    unshipped_invoice = create(:invoice, status: 1)
    create(:invoice, status: 1)

    invoice = Invoice.first

    get "/api/v1/items/find?status=shipped"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(invoice.id)

    get "/api/v1/items/find?status=unshipped"

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(unshipped_invoice.id)
  end

  xit "returns a single instance of item based off description" do
    create_list(:item, 5)

    item = Item.all.first

    get "/api/v1/items/find?description=#{item.description}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(item.id)
  end

  xit "returns a single instance of item based off unit price" do
    item1 = create(:item, unit_price: 1100)
    item2 = create(:item, unit_price: 2245)

    get "/api/v1/items/find?unit_price=11.00"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(item1.id)

    get "/api/v1/items/find?unit_price=22.45"

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(item2.id)
  end

  xit "returns a single instance of item based off merchant id" do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)

    item = Item.all.first

    get "/api/v1/items/find?merchant_id=#{merchant.id}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(item.id)
  end

  xit "returns a single instance of item based off date created" do
    item = create(:item, created_at: "2020-01-10", updated_at: "2020-01-25")

    created_at = item.created_at.to_s

    get "/api/v1/items/find?created_at=#{created_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["name"]).to eq(item.name)
  end

  xit "returns a single instance of item based off date updated" do
    item = create(:item, created_at: "2020-01-10", updated_at: "2020-01-25")

    updated_at = item.updated_at.to_s

    get "/api/v1/items/find?updated_at=#{updated_at}"

    expect(response).to be_successful


    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["name"]).to eq(item.name)
  end
end

xdescribe "item find_all request" do
  it "returns all items that have an id matching the query param" do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)

    get "/api/v1/items/find_all?id=#{item1.id}"

    expect(response).to be_successful

    item1_info = JSON.parse(response.body)

    expect(item1_info["data"].first["attributes"]["id"]).to eq(item1.id)

    get "/api/v1/items/find_all?id=#{item2.id}"

    item2_info = JSON.parse(response.body)

    expect(item2_info["data"].first["attributes"]["id"]).to eq(item2.id)
  end


  it "returns all items that have a name matching the query param" do
    item1 = create(:item, name: "Cool Item")
    item2 = create(:item, name: "Cool Item")
    item3 = create(:item)

    get "/api/v1/items/find_all?name=#{item1.name}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(item2.id)
  end

  it "retuns all items that have a description matching query param" do
    item1 = create(:item, description: "Item is a good item")
    item2 = create(:item, description: "Item is a good item")
    item3 = create(:item)

    get "/api/v1/items/find_all?description=#{item1.description}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(item2.id)
  end

  it "retuns all items that have a unit price matching query param" do
    item1 = create(:item, unit_price: 21689)
    item2 = create(:item, unit_price: 21689)
    item3 = create(:item)

    get "/api/v1/items/find_all?unit_price=216.89"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(item2.id)
  end

  it "returns all items that were created on a specific date" do
    item1 = create(:item, created_at: "2020-01-10", updated_at: "2020-01-25")
    item2 = create(:item, created_at: "2020-01-10", updated_at: "2020-01-31")
    item3 = create(:item, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/items/find_all?created_at=#{item1.created_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(item2.id)

    get "/api/v1/items/find_all?created_at=#{item3.created_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(1)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(item3.id)
  end

  it "returns all items that were updated on a specific date" do
    item1 = create(:item, created_at: "2020-01-10", updated_at: "2020-01-25")
    item2 = create(:item, created_at: "2020-01-10", updated_at: "2020-01-14")
    item3 = create(:item, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/items/find_all?updated_at=#{item1.updated_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(item1.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(item3.id)

    get "/api/v1/items/find_all?updated_at=#{item2.updated_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(1)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(item2.id)
  end

end
