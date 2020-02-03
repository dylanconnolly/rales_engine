require 'rails_helper'

describe "invoice relationships requests" do
  describe "transactions relationship request" do
    it "returns collection of transactions that belong to that invoice" do
      invoice = create(:invoice)
      successful_transaction = create(:transaction, invoice_id: invoice.id)
      failed_transaction = create(:transaction, invoice_id: invoice.id, result: 1)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      expect(response).to be_successful

      transactions_info = JSON.parse(response.body)["data"]

      expect(transactions_info.count).to eq(2)
      expect(transactions_info.first["attributes"]["id"]).to eq(successful_transaction.id)
      expect(transactions_info.last["attributes"]["id"]).to eq(failed_transaction.id)
    end
  end

  describe "invoice items relationship request" do
    it "returns collection of invoice_items belonging to that invoice" do
      invoice = create(:invoice)
      create_list(:invoice_item, 5, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      expect(response).to be_successful

      invoice_items_info = JSON.parse(response.body)["data"]


      expect(invoice_items_info.count).to eq(5)
      invoice_items_info.each do |invoice_item|
        expect(invoice_item["attributes"]["invoice_id"]).to eq(invoice.id)
      end
    end
  end

  describe "items relationship request" do
    it "returns collection of items belonging to that invoice" do
      invoice = create(:invoice)
      create_list(:invoice_item, 5, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/items"

      expect(response).to be_successful

      items_info = JSON.parse(response.body)["data"]

      expect(items_info.count).to eq(5)
    end
  end

  describe "items relationship request" do
    it "returns collection of items belonging to that invoice" do
      invoice = create(:invoice)
      create_list(:invoice_item, 5, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/items"

      expect(response).to be_successful

      items_info = JSON.parse(response.body)["data"]

      expect(items_info.count).to eq(5)
    end
  end

  describe "customer relationship request" do
    it "returns associated customer belonging to that invoice" do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)


      get "/api/v1/invoices/#{invoice.id}/customer"

      expect(response).to be_successful

      customer_info = JSON.parse(response.body)["data"]

      expect(customer_info["attributes"]["id"]).to eq(customer.id)
    end
  end

  describe "merchant relationship request" do
    it "returns associated merchant belonging to that invoice" do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id)


      get "/api/v1/invoices/#{invoice.id}/merchant"

      expect(response).to be_successful

      merchant_info = JSON.parse(response.body)["data"]

      expect(merchant_info["attributes"]["id"]).to eq(merchant.id)
    end
  end
end
