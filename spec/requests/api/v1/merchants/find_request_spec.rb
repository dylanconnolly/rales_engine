require 'rails_helper'

describe "merchant finder API" do
  it "returns a single instance of a merchant based off id params" do
    create_list(:merchant, 10)

    merchant = Merchant.last

    get "/api/v1/merchants/find?id=#{merchant.id}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)
    expect(merchant_info["data"]["attributes"]["name"]).to eq(merchant.name)
  end

  it "returns a single instance of merchant baseed off name" do
    create_list(:merchant, 10)

    merchant = Merchant.last

    get "/api/v1/merchants/find?name=#{merchant.name}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)
    expect(merchant_info["data"]["attributes"]["name"]).to eq(merchant.name)
  end

  it "returns a single instance of merchant based off date created" do
    merchant = create(:merchant, created_at: "2020-01-10", updated_at: "2020-01-25")

    created_at = merchant.created_at.to_s

    get "/api/v1/merchants/find?created_at=#{created_at}"

    expect(response).to be_successful


    merchant_info = JSON.parse(response.body)
    expect(merchant_info["data"]["attributes"]["name"]).to eq(merchant.name)
  end

  it "returns a single instance of merchant based off date updated" do
    merchant = create(:merchant, created_at: "2020-01-10", updated_at: "2020-01-25")

    updated_at = merchant.updated_at.to_s

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    expect(response).to be_successful


    merchant_info = JSON.parse(response.body)
    expect(merchant_info["data"]["attributes"]["name"]).to eq(merchant.name)
  end
end

describe "merchant find_all API" do
  it "returns all merchants that have an id matching the query param" do
    merchant1 = create(:merchant, name: "Bob")
    merchant2 = create(:merchant, name: "Scott")
    merchant3 = create(:merchant, name: "Not Bob")

    get "/api/v1/merchants/find_all?id=#{merchant1.id}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant1.name)
  end


  it "returns all merchants that have a name matching the query param" do
    merchant1 = create(:merchant, name: "Bob")
    merchant2 = create(:merchant, name: "Bob")
    merchant3 = create(:merchant, name: "Not Bob")

    get "/api/v1/merchants/find_all?name=#{merchant1.name}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(2)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant1.name)
    expect(merchant_info["data"].last["attributes"]["name"]).to eq(merchant2.name)
  end

  it "returns all merchants that were created on a specific date" do
    merchant1 = create(:merchant, name: "Bob", created_at: "2020-01-10", updated_at: "2020-01-25")
    merchant2 = create(:merchant, name: "Stove", created_at: "2020-01-10", updated_at: "2020-01-31")
    merchant3 = create(:merchant, name: "Not Bob", created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/merchants/find_all?created_at=#{merchant1.created_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(2)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant1.name)
    expect(merchant_info["data"].last["attributes"]["name"]).to eq(merchant2.name)

    get "/api/v1/merchants/find_all?created_at=#{merchant3.created_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(1)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant3.name)
  end

  it "returns all merchants that were created on a specific date" do
    merchant1 = create(:merchant, name: "Bob", created_at: "2020-01-10", updated_at: "2020-01-25")
    merchant2 = create(:merchant, name: "Stove", created_at: "2020-01-10", updated_at: "2020-01-14")
    merchant3 = create(:merchant, name: "Not Bob", created_at: "2020-01-12", updated_at: "2020-01-25")

    get "/api/v1/merchants/find_all?updated_at=#{merchant1.updated_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(2)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant1.name)
    expect(merchant_info["data"].last["attributes"]["name"]).to eq(merchant3.name)

    get "/api/v1/merchants/find_all?updated_at=#{merchant2.updated_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)

    expect(merchant_info["data"].count).to eq(1)
    expect(merchant_info["data"].first["attributes"]["name"]).to eq(merchant2.name)
  end
end
