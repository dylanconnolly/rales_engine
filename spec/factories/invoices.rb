FactoryBot.define do
  factory :invoice do
    customer
    merchant { nil }
    status { 1 }
  end
end
