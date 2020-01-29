FactoryBot.define do
  factory :item do
    name { "Super Real Item" }
    description { "Item is as real as can be" }
    unit_price { 10234 }
    merchant { nil }
  end
end
