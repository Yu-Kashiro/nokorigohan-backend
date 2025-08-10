class Ingredient < ApplicationRecord
  # アソシエーション
  has_many :user_ingredients, dependent: :destroy
  has_many :users, through: :user_ingredients

  # バリデーション
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :unit, presence: true

  # スコープ
  scope :by_category, ->(category) { where(category: category) }
end
