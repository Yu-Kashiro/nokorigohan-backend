class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :instructions
      t.text :nutritional_info
      t.integer :cooking_time
      t.integer :serving_size
      t.string :recipe_type

      t.timestamps
    end
  end
end
