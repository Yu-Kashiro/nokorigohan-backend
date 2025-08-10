class ShoppingList < ApplicationRecord
  belongs_to :recipe

  # バリデーション
  validates :ingredient_name, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit, presence: true

  # スコープ
  scope :pending, -> { where(purchased: false) }
  scope :purchased, -> { where(purchased: true) }
end
