class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string   :name, default: "no_name"
      t.string   :account_name,      null: false
      t.string   :email,             null: false
      t.string   :avatar
      t.date     :birthday
      t.string   :university
      t.string   :major
      t.string   :school_year
      t.text     :self_introduction
      t.string   :skype
      t.string   :phone
      t.boolean  :administrator,     null: false, default: false
      
      t.string   :password_digest,   null: false
      t.string   :remember_digest
      
      t.string   :activation_digest
      t.boolean  :activated,         null: false, default: false
      t.datetime :activated_at
      
      t.string   :reset_digest
      t.datetime :reset_sent_at
      
      t.boolean  :deleted,           null: false, default: false
      t.datetime :deleted_at
      
      t.boolean  :suspended,         null: false, default: false
      t.datetime :susupended_at
      
      t.timestamps null: false
      
    end
    
    add_index :coaches, :name
    add_index :coaches, :account_name
    add_index :coaches, :university
    add_index :coaches, :major
    add_index :coaches, :school_year
    add_index :coaches, [:name,:created_at]
    add_index :coaches, [:account_name,:created_at]
  end
end
