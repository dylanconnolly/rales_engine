require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "class methods" do
    it "most_revenue" do
      create_list(:invoice, 10)

      Invoice.all.each do |invoice|
        create(:invoice_item, invoice: invoice, item: (create(:item, merchant: invoice.merchant)))
        create(:transaction, invoice: invoice)
      end

      expect(Merchant.most_revenue(5).length).to eq(5)
      expect(Merchant.most_revenue(3).length).to eq(3)
    end

    it "total_revenue_on_date" do
      create_list(:invoice, 10)

      Invoice.all.each do |invoice|
        create(:invoice_item, invoice: invoice, item: (create(:item, merchant: invoice.merchant)))
        create(:transaction, invoice: invoice)
      end

      query = Merchant.total_revenue_on_date(Date.today.strftime('%Y-%m-%d'))
      revenue_on_date = query[0].total_revenue

      expect(revenue_on_date).to eq(10.00)
    end
  end
end
