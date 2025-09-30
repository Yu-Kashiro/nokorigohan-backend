class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.jsonb :ingredients
      t.jsonb :instructions
      t.integer :cooking_time

      t.timestamps
    end
  end
end
