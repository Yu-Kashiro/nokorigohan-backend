FactoryBot.define do
  factory :shopping_list do
    recipe { nil }
    ingredient_name { "MyString" }
    quantity { "9.99" }
    unit { "MyString" }
    purchased { false }
  end
end
