FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "Merchant #{n}" }

    factory :merchant_with_items do
      transient do
        items_count { 5 }
      end

      after(:create) do |merchant, evaluator|
        create_list(:item, evaluator.items_count, merchant: merchant)
      end
    end

    ### can now call the following in spec setup
    # create(:user).posts.length # 0
    # create(:user_with_posts).posts.length # 5
    # create(:user_with_posts, posts_count: 15).posts.length
  end
end
