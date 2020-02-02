require 'rails_helper'

describe 'transactions API' do
  it "returns a list of all transactions" do
    create_list(:transaction, 5)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)["data"]

    expect(transactions.count).to eq(5)
  end

  it "returns a single record of transaction by id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_successful

    transaction_data = JSON.parse(response.body)["data"]

    expect(transaction_data["attributes"]["id"]).to eq(transaction.id)
  end
end
