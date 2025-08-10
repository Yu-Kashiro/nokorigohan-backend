class CreateShoppingLists < ActiveRecord::Migration[8.0]
  def change
    create_table :shopping_lists do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :ingredient_name
      t.decimal :quantity
      t.string :unit
      t.boolean :purchased, default: false

      t.timestamps
    end
  end
end
