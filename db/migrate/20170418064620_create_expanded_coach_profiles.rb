class CreateExpandedCoachProfiles < ActiveRecord::Migration
  def change
    create_table :expanded_coach_profiles do |t|
      t.string :university
      t.string :major
      t.string :school_year
      t.string :skype
      t.boolean :administrator, default: false, null: false
      
      t.timestamps null: false
    end
    
    add_index :expanded_coach_profiles, :university
    add_index :expanded_coach_profiles, :major
    add_index :expanded_coach_profiles, :school_year
    add_index :expanded_coach_profiles, :skype
  end
end
