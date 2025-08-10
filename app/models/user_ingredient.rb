class UserIngredient < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient

  # バリデーション
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :expiration_date, allow_blank: true

  # スコープ
  scope :available, -> { where('expiration_date IS NULL OR expiration_date > ?', Date.current) }
  scope :expiring_soon, -> { where(expiration_date: Date.current..3.days.from_now) }
end
