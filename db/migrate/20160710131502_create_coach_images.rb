class CreateCoachImages < ActiveRecord::Migration
  def change
    create_table :coach_images do |t|
      t.references :coach, null: false  #外部キー
      t.binary :data                    #画像データ
      t.string :content_type            #MEMEタイプ

      t.timestamps null: false
    end
    
    add_index :coach_images, :coach_id
  end
end
