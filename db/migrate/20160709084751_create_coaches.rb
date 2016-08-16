class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string  :name,              null: false                  #ユーザ名（表示名）
      t.string  :full_name                                       #本名
      t.string  :email,             null: false                  #メールアドレス
      t.date    :birthday                                        #生年月日
      t.string  :university                                      #大学
      t.string  :major                                           #学部学科
      t.string  :school_year                                     #学年
      t.string  :self_introduction                               #自己紹介
      t.boolean :administrator,     null: false, default: false  #管理者フラグ
      
      t.timestamps null: false
      
      t.string :password_digest,    null: false

    end
  end
end
