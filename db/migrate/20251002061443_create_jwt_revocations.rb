class CreateJwtRevocations < ActiveRecord::Migration[8.0]
  def change
    create_table :jwt_revocations do |t|
      t.timestamps
    end
  end
end
