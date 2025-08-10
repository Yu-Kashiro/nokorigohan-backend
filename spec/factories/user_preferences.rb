FactoryBot.define do
  factory :user_preference do
    user { nil }
    default_serving_size { 1 }
    nutritional_goals { "MyText" }
    allergies { "MyText" }
    cooking_tools { "MyText" }
    seasonings { "MyText" }
  end
end
