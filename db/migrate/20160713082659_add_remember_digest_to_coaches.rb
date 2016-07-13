class AddRememberDigestToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :remember_digest, :string
  end
end
