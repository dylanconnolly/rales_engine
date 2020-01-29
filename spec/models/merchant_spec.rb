require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "class methods" do
    xit "most_revenue" do
      merchant = create(:merchant_with_items)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      merchant.items.each do |item|
        create(:invoice_item, invoice: invoice, item: item)
      end

      expect(merchant.total_revenue).to eq(500)
    end
  end
end
