class Recipe < ApplicationRecord
  belongs_to :user
  has_many :shopping_lists, dependent: :destroy

  # バリデーション
  validates :title, presence: true
  validates :instructions, presence: true
  validates :cooking_time, presence: true, numericality: { greater_than: 0 }
  validates :serving_size, presence: true, numericality: { greater_than: 0 }
  validates :recipe_type, presence: true, inclusion: { in: %w[leftover_only balanced] }

  # JSONデータのシリアライズ
  serialize :nutritional_info, type: Hash, coder: JSON

  # スコープ
  scope :leftover_only, -> { where(recipe_type: 'leftover_only') }
  scope :balanced, -> { where(recipe_type: 'balanced') }
  scope :recent, -> { order(created_at: :desc) }
end
