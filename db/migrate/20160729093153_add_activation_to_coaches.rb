class AddActivationToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :activation_digest, :string
    add_column :coaches, :activated, :boolean, default: false
    add_column :coaches, :activated_at, :datetime
  end
end
