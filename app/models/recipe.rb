class Recipe < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :instructions, presence: true
  validates :cooking_time, numericality: { greater_than: 0, allow_nil: true }
end
