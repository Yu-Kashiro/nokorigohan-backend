class CreateUserPreferences < ActiveRecord::Migration[8.0]
  def change
    create_table :user_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :default_serving_size, default: 2
      t.text :nutritional_goals
      t.text :allergies
      t.text :cooking_tools
      t.text :seasonings

      t.timestamps
    end
  end
end
