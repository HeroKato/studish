class AddColumnToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :skype, :string
    add_column :coaches, :phone, :string
  end
end
