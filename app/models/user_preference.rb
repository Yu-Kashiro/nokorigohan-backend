class UserPreference < ApplicationRecord
  belongs_to :user

  # バリデーション
  validates :default_serving_size, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }

  # JSONデータのシリアライズ
  serialize :nutritional_goals, type: Hash, coder: JSON
  serialize :allergies, type: Array, coder: JSON
  serialize :cooking_tools, type: Array, coder: JSON
  serialize :seasonings, type: Array, coder: JSON

  # デフォルト値設定
  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.nutritional_goals ||= {
      daily_calories: 2000,
      protein_ratio: 20,
      carb_ratio: 50,
      fat_ratio: 30
    }
    self.allergies ||= []
    self.cooking_tools ||= []
    self.seasonings ||= []
  end
end
