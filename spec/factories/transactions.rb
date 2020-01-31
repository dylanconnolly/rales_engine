FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "10239890128301" }
    credit_card_expiration_date { "" }
    result { 0 }
  end
end
