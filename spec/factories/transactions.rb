FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number, 12092389209390) { |n| "#{n}" }
    credit_card_expiration_date { "" }
    result { 0 }
  end
end
