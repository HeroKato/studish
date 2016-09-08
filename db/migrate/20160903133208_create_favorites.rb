class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :coach, null: false
      t.references :coaching_report, null: false

      t.timestamps null: false
    end
    
    add_index :favorites, :coach_id
    add_index :favorites, :coaching_report_id
    add_index :favorites, :created_at
  end
end
