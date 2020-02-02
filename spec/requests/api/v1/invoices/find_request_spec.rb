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
    unshipped_invoice = create(:invoice, status: 0)
    create(:invoice, status: 0)

    invoice = Invoice.first

    get "/api/v1/invoices/find?status=shipped"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(invoice.id)

    get "/api/v1/invoices/find?status=unshipped"

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(unshipped_invoice.id)
  end

  it "returns a first instance of invoice based off merchant id" do
    merchant = create(:merchant)
    create_list(:invoice, 3, merchant_id: merchant.id)

    invoice = Invoice.first

    get "/api/v1/invoices/find?merchant_id=#{merchant.id}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
  end

  it "returns a single instance of invoice based off customer id" do
    customer = create(:customer)
    create_list(:invoice, 3, customer_id: customer.id)

    invoice = Invoice.first

    get "/api/v1/invoices/find?customer_id=#{customer.id}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
  end

  it "returns a single instance of invoice based off date created" do
    invoice = create(:invoice, created_at: "2020-01-10", updated_at: "2020-01-25")

    created_at = invoice.created_at.to_s

    get "/api/v1/invoices/find?created_at=#{created_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
  end

  it "returns a single instance of invoice based off date updated" do
    invoice = create(:invoice, created_at: "2020-01-10", updated_at: "2020-01-25")

    updated_at = invoice.updated_at.to_s

    get "/api/v1/invoices/find?updated_at=#{updated_at}"

    expect(response).to be_successful


    invoice_info = JSON.parse(response.body)["data"]

    expect(invoice_info["attributes"]["id"]).to eq(invoice.id)
  end
end

describe "invoices find_all request" do
  it "returns all invoices that have an id matching the query param" do
    create_list(:invoice, 3)

    invoice1 = Invoice.first
    invoice3 = Invoice.last

    get "/api/v1/invoices/find_all?id=#{invoice1.id}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice1.id)

    get "/api/v1/invoices/find_all?id=#{invoice3.id}"

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice3.id)
  end


  it "returns all invoices that have a status matching the query param" do
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice, status: 0)
    invoice4 = create(:invoice, status: 0)

    get "/api/v1/invoices/find_all?status=shipped"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice1.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(invoice2.id)

    get "/api/v1/invoices/find_all?status=unshipped"

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice3.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(invoice4.id)
  end

  it "retuns all invoices that have a merchant id matching query param" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant1.id)
    invoice2 = create(:invoice, merchant_id: merchant1.id)
    invoice3 = create(:invoice, merchant_id: merchant2.id)
    invoice4 = create(:invoice, merchant_id: merchant2.id)

    get "/api/v1/invoices/find_all?merchant_id=#{merchant1.id}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice1.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(invoice2.id)

    get "/api/v1/invoices/find_all?merchant_id=#{merchant2.id}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice3.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(invoice4.id)
  end

  it "returns all items that were created on a specific date" do
    invoice1 = create(:invoice, created_at: "2020-01-10", updated_at: "2020-01-25")
    invoice2 = create(:invoice, created_at: "2020-01-10", updated_at: "2020-01-31")
    invoice3 = create(:invoice, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/invoices/find_all?created_at=#{invoice1.created_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice1.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(invoice2.id)

    get "/api/v1/invoices/find_all?created_at=#{invoice3.created_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(1)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice3.id)
  end

  it "returns all invoices that were updated on a specific date" do
    invoice1 = create(:invoice, created_at: "2020-01-10", updated_at: "2020-01-25")
    invoice2 = create(:invoice, created_at: "2020-01-10", updated_at: "2020-01-14")
    invoice3 = create(:invoice, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/invoices/find_all?updated_at=#{invoice1.updated_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(2)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice1.id)
    expect(invoice_info["data"].last["attributes"]["id"]).to eq(invoice3.id)

    get "/api/v1/invoices/find_all?updated_at=#{invoice2.updated_at}"

    expect(response).to be_successful

    invoice_info = JSON.parse(response.body)

    expect(invoice_info["data"].count).to eq(1)
    expect(invoice_info["data"].first["attributes"]["id"]).to eq(invoice2.id)
  end

end
