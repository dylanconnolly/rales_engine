require 'rails_helper'

describe "transaction single finder endpoints" do
  it "can find a single transaction based off id" do
    create_list(:transaction, 5)

    transaction = Transaction.first

    get "/api/v1/transactions/find?id=#{transaction.id}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)["data"]

    expect(transaction_info["attributes"]["id"]).to eq(transaction.id)
  end

  it "returns a single instance of transaction based off credit card number" do
    create_list(:transaction, 5)

    transaction = Transaction.first

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)["data"]

    expect(transaction_info["attributes"]["id"]).to eq(transaction.id)
  end

  it "returns a single instance of transaction based off invoice id" do
    create_list(:transaction, 5)

    transaction = Transaction.first

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)["data"]

    expect(transaction_info["attributes"]["id"]).to eq(transaction.id)
  end

  it "returns a single instance of transaction based off result" do
    transaction1 = create(:transaction, result: 0)
    transaction2 = create(:transaction, result: 1)

    get "/api/v1/transactions/find?result=success"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)["data"]

    expect(transaction_info["attributes"]["id"]).to eq(transaction1.id)

    get "/api/v1/transactions/find?result=failed"

    transaction_info = JSON.parse(response.body)["data"]

    expect(transaction_info["attributes"]["id"]).to eq(transaction2.id)
  end

  it "returns a single instance of transaction based off date created" do
    transaction = create(:transaction, created_at: "2020-01-10", updated_at: "2020-01-25")

    created_at = transaction.created_at.to_s

    get "/api/v1/transactions/find?created_at=#{created_at}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)["data"]

    expect(transaction_info["attributes"]["id"]).to eq(transaction.id)
  end

  it "returns a single instance of transaction based off date updated" do
    transaction = create(:transaction, created_at: "2020-01-10", updated_at: "2020-01-25")

    updated_at = transaction.updated_at.to_s

    get "/api/v1/transactions/find?updated_at=#{updated_at}"

    expect(response).to be_successful


    transaction_info = JSON.parse(response.body)["data"]

    expect(transaction_info["attributes"]["id"]).to eq(transaction.id)
  end
end

describe "transaction find_all request" do
  it "returns all transactions that have an id matching the query param" do
    transaction1 = create(:transaction)
    transaction2 = create(:transaction)
    transaction3 = create(:transaction)

    get "/api/v1/transactions/find_all?id=#{transaction1.id}"

    expect(response).to be_successful

    transaction1_info = JSON.parse(response.body)

    expect(transaction1_info["data"].first["attributes"]["id"]).to eq(transaction1.id)

    get "/api/v1/transactions/find_all?id=#{transaction2.id}"

    transaction2_info = JSON.parse(response.body)

    expect(transaction2_info["data"].first["attributes"]["id"]).to eq(transaction2.id)
  end


  it "returns all transactions that have a credit card number matching the query param" do
    transaction1 = create(:transaction, credit_card_number: "12938129037")
    transaction2 = create(:transaction, credit_card_number: "12938129037")
    transaction3 = create(:transaction, credit_card_number: "09230983829")

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction1.credit_card_number}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)

    expect(transaction_info["data"].count).to eq(2)
    expect(transaction_info["data"].first["attributes"]["id"]).to eq(transaction1.id)
    expect(transaction_info["data"].last["attributes"]["id"]).to eq(transaction2.id)
  end

  it "retuns all transactions that have a result matching query param" do
    transaction1 = create(:transaction, result: 0)
    transaction2 = create(:transaction, result: 0)
    transaction3 = create(:transaction, result: 1)

    get "/api/v1/transactions/find_all?result=success"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)

    expect(transaction_info["data"].count).to eq(2)
    expect(transaction_info["data"].first["attributes"]["id"]).to eq(transaction1.id)
    expect(transaction_info["data"].last["attributes"]["id"]).to eq(transaction2.id)

    get "/api/v1/transactions/find_all?result=failed"

    transaction_info = JSON.parse(response.body)

    expect(transaction_info["data"].count).to eq(1)
    expect(transaction_info["data"].first["attributes"]["id"]).to eq(transaction3.id)
  end

  it "retuns all transactions that have an invoice id matching query param" do
    invoice = create(:invoice)

    transaction1 = create(:transaction, invoice_id: invoice.id)
    transaction2 = create(:transaction, invoice_id: invoice.id)
    transaction3 = create(:transaction, )

    get "/api/v1/transactions/find_all?invoice_id=#{invoice.id}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)

    expect(transaction_info["data"].count).to eq(2)
    expect(transaction_info["data"].first["attributes"]["id"]).to eq(transaction1.id)
    expect(transaction_info["data"].last["attributes"]["id"]).to eq(transaction2.id)
  end

  it "returns all transactions that were created on a specific date" do
    transaction1 = create(:transaction, created_at: "2020-01-10", updated_at: "2020-01-25")
    transaction2 = create(:transaction, created_at: "2020-01-10", updated_at: "2020-01-31")
    transaction3 = create(:transaction, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/transactions/find_all?created_at=#{transaction1.created_at}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)

    expect(transaction_info["data"].count).to eq(2)
    expect(transaction_info["data"].first["attributes"]["id"]).to eq(transaction1.id)
    expect(transaction_info["data"].last["attributes"]["id"]).to eq(transaction2.id)

    get "/api/v1/transactions/find_all?created_at=#{transaction3.created_at}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)

    expect(transaction_info["data"].count).to eq(1)
    expect(transaction_info["data"].first["attributes"]["id"]).to eq(transaction3.id)
  end

  it "returns all transactions that were updated on a specific date" do
    transaction1 = create(:transaction, created_at: "2020-01-10", updated_at: "2020-01-25")
    transaction2 = create(:transaction, created_at: "2020-01-10", updated_at: "2020-01-14")
    transaction3 = create(:transaction, created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/transactions/find_all?updated_at=#{transaction1.updated_at}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)

    expect(transaction_info["data"].count).to eq(2)
    expect(transaction_info["data"].first["attributes"]["id"]).to eq(transaction1.id)
    expect(transaction_info["data"].last["attributes"]["id"]).to eq(transaction3.id)

    get "/api/v1/transactions/find_all?updated_at=#{transaction2.updated_at}"

    expect(response).to be_successful

    transaction_info = JSON.parse(response.body)

    expect(transaction_info["data"].count).to eq(1)
    expect(transaction_info["data"].first["attributes"]["id"]).to eq(transaction2.id)
  end

  it "query params are case insensitive when looking for an item" do
    transaction = create(:transaction, result: 0)
    failed_transaction = create(:transaction, result: 1)


    get "/api/v1/transactions/find?result=SuCCEss"

    expect(response).to be_successful
    transaction_info = JSON.parse(response.body)["data"]
    expect(transaction_info["attributes"]["id"]).to eq(transaction.id)

    get "/api/v1/transactions/find?result=fAILeD"

    expect(response).to be_successful
    transaction_info = JSON.parse(response.body)["data"]
    expect(transaction_info["attributes"]["id"]).to eq(failed_transaction.id)

    get "/api/v1/transactions/find_all?result=SUCCESS"

    expect(response).to be_successful
    transaction_info = JSON.parse(response.body)["data"]
    expect(transaction_info.first["attributes"]["id"]).to eq(transaction.id)

    get "/api/v1/transactions/find_all?result=faiLed"

    expect(response).to be_successful
    transaction_info = JSON.parse(response.body)["data"]
    expect(transaction_info.first["attributes"]["id"]).to eq(failed_transaction.id)
  end
end
