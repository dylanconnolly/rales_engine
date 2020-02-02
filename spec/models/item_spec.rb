require 'rails_helper'

RSpec.describe Item, type: :model do
  it "most_revenue" do
    create_list(:item, 5)

    top_item = Item.last

    number_of_invoice_items = 1
    Item.all.each do |item|
      create_list(:invoice_item, number_of_invoice_items, item: item)
      number_of_invoice_items += 1
    end

    Invoice.all.each do |invoice|
      create(:transaction, invoice: invoice)
    end

    top_items = Item.most_revenue(5)
    
    expect(top_items.length).to eq(5)
    expect(top_items.first).to eq(top_item)
    expect(Item.most_revenue(2).length).to eq(2)
  end
end
