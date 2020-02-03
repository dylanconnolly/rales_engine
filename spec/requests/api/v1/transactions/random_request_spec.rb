require 'rails_helper'

describe "random transaction API" do
  it "returns a random transaction object" do
    create_list(:transaction, 150)
    transaction_ids = []

    Transaction.all.each do |transaction|
      transaction_ids << transaction.id
    end

    get '/api/v1/transactions/random'

    expect(response).to be_successful

    parse = JSON.parse(response.body)
    random_transaction1 = parse["data"]["attributes"]["id"]

    expect(transaction_ids).to include(random_transaction1)

    get '/api/v1/transactions/random'
    parse = JSON.parse(response.body)
    random_transaction2 = parse["data"]["attributes"]["id"]

    expect(transaction_ids).to include(random_transaction2)
    expect(random_transaction1).to_not eq(random_transaction2)
  end
end
