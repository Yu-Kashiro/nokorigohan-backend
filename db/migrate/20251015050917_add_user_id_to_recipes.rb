class AddUserIdToRecipes < ActiveRecord::Migration[8.0]
  def change
    add_reference :recipes, :user, null: true, foreign_key: true

    # 既存のレシピがある場合は、最初のユーザーを割り当てる
    # 本番環境では適切なユーザーを割り当ててください
    reversible do |dir|
      dir.up do
        if User.exists? && Recipe.exists?
          first_user = User.first
          Recipe.where(user_id: nil).update_all(user_id: first_user.id)
        end
      end
    end

    # user_idをnot nullに変更
    change_column_null :recipes, :user_id, false
  end
end
