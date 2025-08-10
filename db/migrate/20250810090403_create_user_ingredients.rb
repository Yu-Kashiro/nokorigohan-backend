class CreateUserIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :user_ingredients do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.decimal :quantity
      t.date :expiration_date

      t.timestamps
    end
  end
end
