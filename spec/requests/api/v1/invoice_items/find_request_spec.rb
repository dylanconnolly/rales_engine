require 'rails_helper'

describe "invoice single finder endpoints" do
  it "can find a single invoice_item based off id" do
    create_list(:invoice_item, 5)

    invoice_item = InvoiceItem.first

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)["data"]

    expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "returns a first instance of invoice_item based off quantity" do
    create_list(:invoice_item, 3, quantity: 10)
    invoice_item_with_5_quantity = create(:invoice_item, quantity: 5)

    invoice_item = InvoiceItem.first

    get "/api/v1/invoice_items/find?quantity=10"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)["data"]

    expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)

    get "/api/v1/invoice_items/find?quantity=5"

    invoice_item_info = JSON.parse(response.body)["data"]

    expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item_with_5_quantity.id)
  end

  it "returns a single instance of invoice_item based off unit price" do
    invoice_item1 = create(:invoice_item, unit_price: 1100)
    invoice_item2 = create(:invoice_item, unit_price: 2245)

    get "/api/v1/invoice_items/find?unit_price=11.00"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)["data"]

    expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item1.id)

    get "/api/v1/invoice_items/find?unit_price=22.45"

    invoice_item_info = JSON.parse(response.body)["data"]

    expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item2.id)
  end

  it "returns a first instance of invoice_item based off item id" do
    item = create(:item)
    create_list(:invoice_item, 3, item_id: item.id)

    invoice_item = InvoiceItem.first

    get "/api/v1/invoice_items/find?item_id=#{item.id}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)["data"]

    expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "returns a single instance of invoice_item based off invoice id" do
    invoice = create(:invoice)
    create_list(:invoice_item, 3, invoice_id: invoice.id)

    invoice_item = InvoiceItem.first

    get "/api/v1/invoice_items/find?invoice_id=#{invoice.id}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)["data"]

    expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "returns a single instance of invoice_item based off date created" do
    invoice_item = create(:invoice_item, created_at: "2020-01-10", updated_at: "2020-01-25")

    created_at = invoice_item.created_at.to_s

    get "/api/v1/invoice_items/find?created_at=#{created_at}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)["data"]

    expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "returns a single instance of invoice_item based off date updated" do
    invoice_item = create(:invoice_item, created_at: "2020-01-10", updated_at: "2020-01-25")

    updated_at = invoice_item.updated_at.to_s

    get "/api/v1/invoice_items/find?updated_at=#{updated_at}"

    expect(response).to be_successful


    invoice_item_info = JSON.parse(response.body)["data"]

    expect(invoice_item_info["attributes"]["id"]).to eq(invoice_item.id)
  end
end

describe "invoice_items find_all request" do
  it "returns all invoice_items that have an id matching the query param" do
    create_list(:invoice_item, 3)

    invoice_item1 = InvoiceItem.first
    invoice_item3 = InvoiceItem.last

    get "/api/v1/invoice_items/find_all?id=#{invoice_item1.id}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item1.id)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item3.id}"

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item3.id)
  end


  it "returns all invoice_items that have a quantity matching the query param" do
    invoice_item1 = create(:invoice_item, quantity: 10)
    invoice_item2 = create(:invoice_item, quantity: 10)
    invoice_item3 = create(:invoice_item, quantity: 5)
    invoice_item4 = create(:invoice_item, quantity: 5)

    get "/api/v1/invoice_items/find_all?quantity=10"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(2)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item1.id)
    expect(invoice_item_info["data"].last["attributes"]["id"]).to eq(invoice_item2.id)

    get "/api/v1/invoice_items/find_all?quantity=5"

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(2)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item3.id)
    expect(invoice_item_info["data"].last["attributes"]["id"]).to eq(invoice_item4.id)
  end

  it "retuns all invoice_items that have a unit price matching query param" do
    invoice_item1 = create(:invoice_item, unit_price: 1100)
    invoice_item2 = create(:invoice_item, unit_price: 1100)
    invoice_item3 = create(:invoice_item, unit_price: 2245)
    invoice_item4 = create(:invoice_item, unit_price: 2245)

    get "/api/v1/invoice_items/find_all?unit_price=11.00"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(2)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item1.id)
    expect(invoice_item_info["data"].last["attributes"]["id"]).to eq(invoice_item2.id)

    get "/api/v1/invoice_items/find_all?unit_price=22.45"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(2)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item3.id)
    expect(invoice_item_info["data"].last["attributes"]["id"]).to eq(invoice_item4.id)
  end

  it "returns all invoice_items that have an item id matching query param" do
    item1 = create(:item)
    item2 = create(:item)

    invoice_item1 = create(:invoice_item, item_id: item1.id)
    invoice_item2 = create(:invoice_item, item_id: item1.id)
    invoice_item3 = create(:invoice_item, item_id: item2.id)
    invoice_item4 = create(:invoice_item, item_id: item2.id)

    get "/api/v1/invoice_items/find_all?item_id=#{item1.id}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(2)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item1.id)
    expect(invoice_item_info["data"].last["attributes"]["id"]).to eq(invoice_item2.id)

    get "/api/v1/invoice_items/find_all?item_id=#{item2.id}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(2)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item3.id)
    expect(invoice_item_info["data"].last["attributes"]["id"]).to eq(invoice_item4.id)
  end

  it "returns all invoice_items that were created on a specific date" do
    invoice_item1 = create(:invoice_item, created_at: "2020-01-10", updated_at: "2020-01-25")
    invoice_item2 = create(:invoice_item, created_at: "2020-01-10", updated_at: "2020-01-31")
    invoice_item3 = create(:invoice_item, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_item1.created_at}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(2)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item1.id)
    expect(invoice_item_info["data"].last["attributes"]["id"]).to eq(invoice_item2.id)

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_item3.created_at}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(1)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item3.id)
  end

  it "returns all invoice_items that were updated on a specific date" do
    invoice_item1 = create(:invoice_item, created_at: "2020-01-10", updated_at: "2020-01-25")
    invoice_item2 = create(:invoice_item, created_at: "2020-01-10", updated_at: "2020-01-14")
    invoice_item3 = create(:invoice_item, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item1.updated_at}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(2)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item1.id)
    expect(invoice_item_info["data"].last["attributes"]["id"]).to eq(invoice_item3.id)

    get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item2.updated_at}"

    expect(response).to be_successful

    invoice_item_info = JSON.parse(response.body)

    expect(invoice_item_info["data"].count).to eq(1)
    expect(invoice_item_info["data"].first["attributes"]["id"]).to eq(invoice_item2.id)
  end
end
