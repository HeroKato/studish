class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string  :name,              null: false                  #ユーザ名（表示名）
      t.string  :full_name,         null: false                  #本名
      t.string  :email,             null: false                  #メールアドレス
      t.date    :birthday,          null: false                  #生年月日
      t.string  :university,        null: false                  #大学
      t.string  :major,             null: false                  #学部学科
      t.string  :school_year,       null: false                  #学年
      t.string  :subject,           null: false                  #指導科目
      t.string  :self_introduction, null: false                  #自己紹介
      t.boolean :administrator,     null: false, default: false  #管理者フラグ
      
      t.timestamps null: false
      
      t.string :password_digest,    null: false

      
    end
  end
end
