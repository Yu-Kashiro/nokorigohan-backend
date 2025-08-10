class User < ApplicationRecord
  has_secure_password

  # アソシエーション
  has_one :user_preference, dependent: :destroy
  has_many :user_ingredients, dependent: :destroy
  has_many :ingredients, through: :user_ingredients
  has_many :recipes, dependent: :destroy

  # バリデーション
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  # ユーザー作成後に設定を初期化
  after_create :create_default_preference

  private

  def create_default_preference
    UserPreference.create!(user: self)
  end
end
