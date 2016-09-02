class RenameFullnameColumnToCoaches < ActiveRecord::Migration
  def change
    rename_column :coaches, :full_name, :account_name
  end
end
