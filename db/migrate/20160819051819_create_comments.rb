class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :coaching_report, null: false
      t.references :coach, null: false
      t.integer    :commented_coach_id
      t.text       :body
      t.boolean    :read_flag, default: false

      t.timestamps null: false
    end
    
    add_index :comments, :coaching_report_id
    add_index :comments, :coach_id
  end
end
