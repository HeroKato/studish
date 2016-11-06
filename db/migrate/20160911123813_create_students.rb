class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name, default: "no_name"
      t.string :account_name, null: false
      t.string :email, null: false
      t.string :avatar, default: nil
      t.text :self_introduction
      t.string :password_digest, null: false
      t.string :remember_digest
      
      t.string :activation_digest
      t.boolean :activated, null: false, default: false
      t.datetime :activated_at
      
      t.string :reset_digest
      t.datetime :reset_sent_at
      
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      
      t.boolean :suspended, null: false, default: false
      t.datetime :suspended_at

      t.timestamps null: false
    end
    
    add_index :students, :name
    add_index :students, :account_name
    add_index :students, :email
    add_index :students, :activated
    add_index :students, :deleted
    add_index :students, :suspended
    add_index :students, [:name, :created_at]
    add_index :students, [:account_name, :created_at]
    add_index :students, [:activated, :created_at]
    add_index :students, [:deleted, :created_at]
    add_index :students, [:suspended, :created_at]
  end
end
