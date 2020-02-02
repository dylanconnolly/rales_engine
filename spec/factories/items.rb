FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    description { "Item is as real as can be. Capital word begins every sentance. Make sure it stays capitalized." }
    sequence(:unit_price, 1000) { |n| n }
    merchant
  end
end
