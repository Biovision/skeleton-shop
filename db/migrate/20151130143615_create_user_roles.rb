class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.timestamps null: false
      t.references :user, index: true, foreign_key: true
      t.integer :role, limit: 2, null: false
    end
  end
end
