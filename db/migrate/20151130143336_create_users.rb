class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps null: false
      t.string :login, null: false
      t.string :password_digest, null: false
      t.string :email
    end

    add_index :users, :login, unique: true
  end
end
