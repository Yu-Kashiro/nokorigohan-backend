FactoryBot.define do
  factory :recipe do
    user { nil }
    title { "MyString" }
    instructions { "MyText" }
    nutritional_info { "MyText" }
    cooking_time { 1 }
    serving_size { 1 }
    recipe_type { "MyString" }
  end
end
