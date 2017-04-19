class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "user_type", default: "student", null: false
      t.string "name", default: "no_name"
      t.string "account_name", null: false
      t.string "email", null:false
      t.string "avatar", default: nil
      t.text "self_introduction"
      t.string "password_digest", null: false
      t.string "remember_digest"
      t.string "activation_digest"
      t.boolean "activated", default: false, null: false
      t.datetime "activated_at"
      t.string "reset_digest"
      t.datetime "reset_sent_at"
      t.boolean "deleted", default: false, null: false
      t.datetime "deleted_at"
      t.boolean "suspended", default: false, null: false
      t.datetime "suspended_at"

      t.timestamps null: false
    end
    
    add_index :users, :name
    add_index :users, :account_name
    add_index :users, :email
    add_index :users, :activated
    add_index :users, :deleted
    add_index :users, :suspended
    add_index :users, [:name, :created_at]
    add_index :users, [:account_name, :created_at]
    add_index :users, [:activated, :created_at]
    add_index :users, [:deleted, :created_at]
    add_index :users, [:suspended, :created_at]
  end
end
