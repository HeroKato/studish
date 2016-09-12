class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :account_name, null: false
      t.string :email, null: false
      t.text :self_introduction
      t.string :password_digest, null: false

      t.timestamps null: false
    end
    
    add_index :students, :name
    add_index :students, :account_name
    add_index :students, :email
  end
end
