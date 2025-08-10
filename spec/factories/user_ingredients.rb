FactoryBot.define do
  factory :user_ingredient do
    user { nil }
    ingredient { nil }
    quantity { "9.99" }
    expiration_date { "2025-08-10" }
  end
end
